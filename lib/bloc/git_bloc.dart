import 'package:communication_bloc/bloc/git_event.dart';
import 'package:communication_bloc/bloc/git_state.dart';
import 'package:communication_bloc/connectivity/connectivity_bloc.dart';
import 'package:communication_bloc/repositories/git_repo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GitBloc extends Bloc<GitEvent, GitState> {
  final GitRepoRepository _repoRepository;
  final ConnectivityBloc connectivityBloc;

  GitBloc({required GitRepoRepository repoRepository, required this.connectivityBloc})
      : _repoRepository = repoRepository,
        super(EmptyGitState()) {
    on<GetRepositoryByPage>(_getRepositoryByPage);
    on<ConnectionStateEvent>(_connectionStateEvent);

    connectivityBloc.stream.listen((connectState) => add(ConnectionStateEvent(state: connectState)));
  }

  Future<void> _connectionStateEvent(ConnectionStateEvent event, Emitter<GitState> emit) async {
    emit(state.connection(state: event.state));
  }

  Future<void> _getRepositoryByPage(
    GetRepositoryByPage event,
    Emitter<GitState> emit,
  ) async {
    emit(state.loading());
    try {
      final reposResponse = await _repoRepository.fetchGitRepos(page: event.page, search: 'Flutter');
      emit(state.loaded(repos: reposResponse));
    } catch (e) {
      emit(state.failure(message: e.toString()));
    }
  }
}
