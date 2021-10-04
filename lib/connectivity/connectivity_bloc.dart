import 'package:communication_bloc/connectivity/connectivity_event.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(Empty()) {
    on<CheckConnectivity>(_checkConnectivity);

    add(CheckConnectivity());
  }

  Future<void> _checkConnectivity(
    CheckConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        emit(Connected());
      } else {
        emit(NotConnected());
      }
    });
  }
}
