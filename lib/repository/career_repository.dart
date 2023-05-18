import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/career_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CareerRepository {
  Future<CommonResponse> postCareerStatus({id, status}) async {
    print(id);
    print(status);

    var baseUrl = "${AppConfig.BASE_URL}/member/career-status/update";
    var accessToken = prefs.getString("_accessToken");
    var postBody = jsonEncode({
      "status": status ? 1 : 0,
      "id": id,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var responseBody = commonResponseFromJson(response.body);

    if (responseBody.result == true) {
      store.dispatch(careerGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: responseBody.message, color: MyTheme.success));
    } else {
      store.dispatch(ShowMessageAction(
          msg: responseBody.message, color: MyTheme.failure));
    }

    return responseBody;
  }
}
