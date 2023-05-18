import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/spiritual_background_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/spiritual_social_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/spiritual_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';


ThunkAction<AppState> spiritualSocialUpdateMiddleware({
  context,
  dynamic religion,
  dynamic caste,
  dynamic sub_caste,
  dynamic ethnicity,
  dynamic personal_value,
  dynamic family_value,
  dynamic community_value,
}) {
  return (Store<AppState> store) async {
    store.dispatch(SpiritualSaveChanges());

    var baseUrl = "${AppConfig.BASE_URL}/member/spiritual-background/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({

      "member_religion_id": religion  ,
      "member_caste_id": caste,
      "member_sub_caste_id": sub_caste,
      "ethnicity": ethnicity,
      "personal_value": personal_value,
      "family_value_id": family_value,
      "community_value": community_value,
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = spiritualBackgroundUpdateResponseFromJson(response.body);

      store.dispatch(SpiritualSaveChanges());
      store.dispatch(spiritualSocialGetMiddleware());






      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(SpiritualBackgroundUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
