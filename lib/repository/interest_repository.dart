import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/interest_request_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/my_interest_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class InterestRepository {
  Future<MyInterestResponse> fetchMyInterest({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/my-interests?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = myInterestResponseFromJson(response.body);

    return data;
  }

  Future<InterestRequestResponse> fetchInterestRequests({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/interest-requests?page=$page";

    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = interestRequestResponseFromJson(response.body);

    return data;
  }
}
