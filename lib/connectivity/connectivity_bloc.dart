import 'package:communication_bloc/connectivity/connectivity_event.dart';
import 'package:communication_bloc/connectivity/connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(Empty()) {
    on<UpdateConnectivity>(_updateConnectivity);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      add(UpdateConnectivity(result));
    });
  }

  Future<void> _updateConnectivity(
    UpdateConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    if (event.result == ConnectivityResult.wifi || event.result == ConnectivityResult.mobile) {
      emit(Connected());
    } else {
      emit(NotConnected());
    }
  }
}
