import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/addon_check_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/app_info_response.dart';
import 'package:http/http.dart' as http;

class AppInfoRepository {
  // fetch app info list

  Future<AppInfoResponse> fetchAppInfo() async {
    var baseUrl = "${AppConfig.BASE_URL}/app-info";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = appInfoResponseFromJson(response.body);
    return data;
  }

  Future<AddonCheckResponse> fetchAddonCheck() async {
    var baseUrl = "${AppConfig.BASE_URL}/addon-check";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = addonCheckResponseFromJson(response.body);
    return data;
  }
}
