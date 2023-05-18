import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/contact_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/contact_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> contactMiddleware({
  context,
  dynamic email,
}) {
  return (Store<AppState> store) async {
    store.dispatch(Cdsave());
    var baseUrl = "${AppConfig.BASE_URL}/member/contact-info/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "email": email,
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = contactUpdatetResponseFromJson(response.body);
      store.dispatch(Cdsave());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(ContactUpdatetResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
