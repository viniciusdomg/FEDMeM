import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class HardwareDataSource {
  Future<int> getBatteryLevel();
  Future<String> getNetworkType();
}

class HardwareDataSourceImpl implements HardwareDataSource {
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();

  @override
  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }

  @override
  Future<String> getNetworkType() async {
    final List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return 'Wi-Fi';
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Simplificação: agrupa conexões móveis (3G/4G/5G)
      return 'Mobile';
    }
    return 'None';
  }
}