import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/package_history_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/package/package_list_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:active_matrimonial_flutter_app/models_response/package/packge_details_response.dart';

class PackageRepository {
  // fetch package list

  Future<PackageListResponse> fetchPackageList() async {
    var baseUrl = "${AppConfig.BASE_URL}/packages";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = packageListResponseFromJson(response.body);
    return data;
  }

  // fetch package details
  Future<PackageDetailsResponse> fetchPackageDetails() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/package-details";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = packageDetailsResponseFromJson(response.body);

    return data;
  }

  // fetch package history
  Future<PackageHistoryResponse> fetchPackageHistory({page}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/package-purchase-history?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = packageHistoryResponseFromJson(response.body);

    return data;
  }
}
