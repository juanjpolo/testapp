import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/cat/presentation/bloc/network/bloc/network_bloc.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetworkInfoImp(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  static void observeNetwork() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      } else {
        NetworkBloc().add(const NetworkNotify());
      }
    });
  }
}
