import '../models/git_repo.dart';

abstract class GitRepoRepository {
  Future<List<GitRepo>> fetchGitRepos({
    required int page,
    required String search,
  });
}
