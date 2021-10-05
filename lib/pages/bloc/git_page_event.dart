import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:equatable/equatable.dart';

abstract class GitPageEvent extends Equatable {}

class ChangeGitStateEvent extends GitPageEvent {
  final GitState gitState;

  ChangeGitStateEvent({
    required this.gitState,
  });

  @override
  List<Object?> get props => [
        gitState,
      ];
}

class ChangeConnectivityState extends GitPageEvent {
  final ConnectivityState connectivityState;

  ChangeConnectivityState({
    required this.connectivityState,
  });

  @override
  List<Object?> get props => [
        connectivityState,
      ];
}
