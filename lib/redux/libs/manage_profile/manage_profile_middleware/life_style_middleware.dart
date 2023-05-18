import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/life_style_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/life_style_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/life_style_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> life_style_Middleware(
    {context,
      dynamic diet,
      dynamic drink,
      dynamic smoke,
      dynamic living_with}) {
  return (Store<AppState> store) async {

    store.dispatch(SaveChanges());
    var baseUrl = "${AppConfig.BASE_URL}/member/life-style/update";
    var accessToken = prefs.getString(Const.accessToken);
    var postBody = jsonEncode({
      "diet": diet,
      "drink": drink,
      "smoke":smoke,
      "living_with": living_with
    });



    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = lifeStyleUpdateResponseFromJson(response.body);
      store.dispatch(SaveChanges());
      store.dispatch(lifeStyleGetMiddleware());


      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(LifeStyleUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
