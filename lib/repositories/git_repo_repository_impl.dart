import 'package:communication_bloc/models/git_repo.dart';
import 'package:dio/dio.dart';
import 'git_repo_repository.dart';

class GitRepoRepositoryImpl implements GitRepoRepository {
  final Dio _dio;
  GitRepoRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<GitRepo>> fetchGitRepos({
    required int page,
    required String search,
  }) async {
    try {
      final response = await _dio.get(
          'https://api.github.com/search/repositories?q=$search&page=$page&per_page=15');
      return (response.data['items'] as List)
          .map((e) => GitRepo.fromMap(e))
          .toList();
    } catch (e) {
      throw ('Erro inesperado ao buscar repositórios');
    }
  }
}
