import 'package:communication_bloc/bloc/git_bloc.dart';
import 'package:communication_bloc/bloc/git_event.dart';
import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_bloc.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:communication_bloc/pages/bloc/git_page_bloc.dart';
import 'package:communication_bloc/pages/bloc/git_page_event.dart';
import 'package:communication_bloc/pages/bloc/git_page_state.dart';
import 'package:communication_bloc/repositories/git_repo_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';

class GitPage extends StatefulWidget {
  const GitPage({Key? key}) : super(key: key);

  @override
  _GitPageState createState() => _GitPageState();
}

class _GitPageState extends State<GitPage> {
  var page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GitPageBloc>(
      create: (context) => GitPageBloc(
        connectivityBloc: ConnectivityBloc(),
        gitBloc: GitBloc(
          repoRepository: GitRepoRepositoryImpl(
            dio: Dio(),
          ),
        ),
      )..gitBloc.add(GetRepositoryByPage(page: page)),
      child: BlocConsumer<GitPageBloc, GitPageState>(
        listenWhen: (previousState, newState) {
          return previousState.connectivityState != newState.connectivityState;
        },
        listener: (context, state) {
          if (state.connectivityState is NotConnected) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Sem conexão')));
          }
          if (state.connectivityState is Connected) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Com conexão')));
          }
        },
        builder: (context, state) {
          final bloc = context.read<GitPageBloc>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      page++;
                      bloc.gitBloc.add(GetRepositoryByPage(page: page));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: state.gitState.repos.length,
                  itemBuilder: (context, index) {
                    var item = state.gitState.repos[index];
                    return ListTile(
                      title: Text(item.name),
                    );
                  },
                ),
                Onstage(
                  onStage: state.gitState is LoadingState,
                  child: Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Onstage extends Offstage {
  const Onstage({Key? key, required bool onStage, required Widget child})
      : super(key: key, offstage: !onStage, child: child);
}
