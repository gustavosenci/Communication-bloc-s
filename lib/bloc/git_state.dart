import 'package:communication_bloc/models/git_repo.dart';
import 'package:equatable/equatable.dart';

abstract class GitState extends Equatable {
  final List<GitRepo> repos;

  const GitState({this.repos = const []});

  GitState empty() => EmptyGitState();
  GitState loading() => LoadingState(repos: repos);
  GitState failure({required String message}) => FailureState(message: message, repos: repos);
  GitState loaded({required List<GitRepo> repos}) => LoadedGitState(repos: repos);

  @override
  List<Object?> get props => [repos];
}

class EmptyGitState extends GitState {}

class LoadingState extends GitState {
  const LoadingState({required List<GitRepo> repos}) : super(repos: repos);
}

class FailureState extends GitState {
  final String message;

  const FailureState({required this.message, required List<GitRepo> repos}) : super(repos: repos);

  @override
  List<Object?> get props => [...super.props, message];
}

class LoadedGitState extends GitState {
  const LoadedGitState({required List<GitRepo> repos}) : super(repos: repos);
}
