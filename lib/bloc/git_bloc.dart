import 'package:communication_bloc/bloc/git_event.dart';
import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/repositories/git_repo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GitBloc extends Bloc<GitEvent, GitState> {
  final GitRepoRepository _repoRepository;

  GitBloc({required GitRepoRepository repoRepository})
      : _repoRepository = repoRepository,
        super(EmptyGitState()) {
    on<GetRepositoryByPage>(_getRepositoryByPage);
  }

  Future<void> _getRepositoryByPage(
    GetRepositoryByPage event,
    Emitter<GitState> emit,
  ) async {
    emit(state.loading());
    try {
      final reposResponse =
          await _repoRepository.fetchGitRepos(page: 1, search: 'Flutter');
      emit(state.loaded(repos: reposResponse));
    } catch (e) {
      emit(state.failure(message: e.toString()));
    }
  }
}
