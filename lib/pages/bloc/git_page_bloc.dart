import 'package:communication_bloc/bloc/git_bloc.dart';
import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_bloc.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:communication_bloc/pages/bloc/git_page_event.dart';
import 'package:communication_bloc/pages/bloc/git_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GitPageBloc extends Bloc<GitPageEvent, GitPageState> {
  final GitBloc gitBloc;
  final ConnectivityBloc connectivityBloc;

  GitPageBloc({
    required this.gitBloc,
    required this.connectivityBloc,
  }) : super(
          CurrentPageState(
            gitState: EmptyGitState(),
            connectivityState: Empty(),
          ),
        ) {
    on<ChangeGitStateEvent>(_changeGitStateEvent);
    on<ChangeConnectivityState>(_changeConnectivityState);

    gitBloc.stream.listen((gitBlocState) {
      add(ChangeGitStateEvent(gitState: gitBlocState));
    });

    connectivityBloc.stream.listen((connectivityBlocState) {
      add(ChangeConnectivityState(connectivityState: connectivityBlocState));
    });
  }

  Future<void> _changeGitStateEvent(
    ChangeGitStateEvent event,
    Emitter<GitPageState> emit,
  ) async {
    emit(state.currentState(gitState: event.gitState));
  }

  Future<void> _changeConnectivityState(
    ChangeConnectivityState event,
    Emitter<GitPageState> emit,
  ) async {
    emit(state.currentState(connectivityState: event.connectivityState));
  }
}
