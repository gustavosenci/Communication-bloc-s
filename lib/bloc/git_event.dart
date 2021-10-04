import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:equatable/equatable.dart';

abstract class GitEvent extends Equatable {}

class GetRepositoryByPage extends GitEvent {
  final int page;

  GetRepositoryByPage({required this.page});

  @override
  List<Object?> get props => [page];
}

class ConnectionStateEvent extends GitEvent {
  final ConnectivityState state;

  ConnectionStateEvent({required this.state});

  @override
  List<Object?> get props => [state];
}
