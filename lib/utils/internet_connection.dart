import 'package:connectivity/connectivity.dart';

class InternetConnection {
  static Future<bool> check() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    } else {
      // showAlertToast(kErrorNetwork);
      return false;
    }
  }
}
