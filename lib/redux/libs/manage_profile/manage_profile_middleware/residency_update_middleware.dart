import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/residency_info_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/residency_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/residency_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> residencyUpdateMiddleware({
  context,
  dynamic birth_country,
  dynamic residency_country,
  dynamic growup_country,
  dynamic immigration_status,
}) {
  return (Store<AppState> store) async {


    // print('in residency update middleware');
    // print(birth_country);
    // print(residency_country);
    // print(growup_country);
    // print(immigration_status);

    store.dispatch(ResidencySaveChanges());

    var baseUrl = "${AppConfig.BASE_URL}/member/residency-info/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "birth_country_id": birth_country,
      "recidency_country_id": residency_country,
      "growup_country_id": growup_country,
      "immigration_status": immigration_status,
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = residencyInfoUpdateResponseFromJson(response.body);
      store.dispatch(ResidencySaveChanges());
      store.dispatch(residencyGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(ResidencyInfoUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
