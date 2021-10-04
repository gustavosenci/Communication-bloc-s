import 'package:connectivity/connectivity.dart';

abstract class ConnectivityEvent {
  final ConnectivityResult result;

  ConnectivityEvent(this.result);
}

class UpdateConnectivity extends ConnectivityEvent {
  UpdateConnectivity(ConnectivityResult result) : super(result);
}
