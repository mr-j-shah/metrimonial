import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/career_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/education_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/family_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/career_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/education_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/career_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> careerMiddleware(
    {context,
    dynamic designation,
    dynamic company,
    dynamic start,
    dynamic end}) {
  return (Store<AppState> store) async {
    store.dispatch(CareerLoader.save_changes);
    var baseUrl = "${AppConfig.BASE_URL}/member/career";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "designation": designation,
      "company": company,
      "start": start,
      "end": end
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = careerResponseFromJson(response.body);
      store.dispatch(CareerLoader.save_changes);

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);
      store.dispatch(careerGetMiddleware());

      store.dispatch(CareerResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
