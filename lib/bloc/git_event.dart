import 'package:equatable/equatable.dart';

abstract class GitEvent extends Equatable {}

class GetRepositoryByPage extends GitEvent {
  final int page;

  GetRepositoryByPage({required this.page});

  @override
  List<Object?> get props => [page];
}