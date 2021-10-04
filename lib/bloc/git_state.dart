import 'package:communication_bloc/models/git_repo.dart';
import 'package:equatable/equatable.dart';

abstract class GitState extends Equatable {
  final List<GitRepo> repos;

  const GitState({this.repos = const []});

  EmptyGitState empty() => EmptyGitState();
  LoadingState loading() => LoadingState(repos: repos);
  FailureState failure({required String message}) =>
      FailureState(message: message, repos: repos);
  LoadedGitState loaded({required List<GitRepo> repos}) =>
      LoadedGitState(repos: repos);

  @override
  List<Object?> get props => [repos];
}

class EmptyGitState extends GitState {}

class LoadingState extends GitState {
  const LoadingState({required List<GitRepo> repos}) : super(repos: repos);
}

class FailureState extends GitState {
  final String message;

  const FailureState({required this.message, required List<GitRepo> repos})
      : super(repos: repos);

  @override
  List<Object?> get props => [...super.props, message];
}

class LoadedGitState extends GitState {
  const LoadedGitState({required List<GitRepo> repos}) : super(repos: repos);
}
