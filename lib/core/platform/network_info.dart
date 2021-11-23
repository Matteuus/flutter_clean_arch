import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // late final DataConnectionChecker connectionChecker;

  // NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected =>
      Connectivity().checkConnectivity().then((connectivityResult) {
        if (connectivityResult == ConnectivityResult.mobile) {
          return true;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          return true;
        }
        return false;
      });
}
