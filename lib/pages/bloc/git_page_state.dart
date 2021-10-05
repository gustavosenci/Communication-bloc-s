import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:equatable/equatable.dart';

abstract class GitPageState extends Equatable {
  final GitState gitState;
  final ConnectivityState connectivityState;

  const GitPageState({
    required this.gitState,
    required this.connectivityState,
  });

  GitPageState currentState({
    GitState? gitState,
    ConnectivityState? connectivityState,
  }) =>
      CurrentPageState(
        gitState: gitState ?? this.gitState,
        connectivityState: connectivityState ?? this.connectivityState,
      );

  @override
  List<Object?> get props => [gitState, connectivityState];
}

class CurrentPageState extends GitPageState {
  const CurrentPageState({
    required GitState gitState,
    required ConnectivityState connectivityState,
  }) : super(
          gitState: gitState,
          connectivityState: connectivityState,
        );
}
