import 'package:communication_bloc/bloc/git_bloc.dart';
import 'package:communication_bloc/bloc/git_event.dart';
import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_bloc.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:communication_bloc/repositories/git_repo_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide ConnectionState;

class GitPage extends StatefulWidget {
  const GitPage({Key? key}) : super(key: key);

  @override
  _GitPageState createState() => _GitPageState();
}

class _GitPageState extends State<GitPage> {
  late final GitBloc bloc;

  var page = 1;

  @override
  void initState() {
    super.initState();
    bloc = GitBloc(repoRepository: GitRepoRepositoryImpl(dio: Dio()), connectivityBloc: ConnectivityBloc());
    bloc.stream.listen((state) {
      if (state is FailureState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      }
      if (state is ConnectionState) {
        final message = state.state is Connected ? 'Você está online' : 'Você está offline';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }

      setState(() {});
    });
    bloc.add(GetRepositoryByPage(page: page));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = bloc.state;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                page++;
                bloc.add(GetRepositoryByPage(page: page));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: bloc.state.repos.length,
            itemBuilder: (context, index) {
              final item = bloc.state.repos[index];
              return ListTile(
                title: Text(item.name),
              );
            },
          ),
          Onstage(
            onStage: state is LoadingState,
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
  }
}

class Onstage extends Offstage {
  const Onstage({Key? key, required bool onStage, required Widget child}) : super(key: key, offstage: !onStage, child: child);
}
