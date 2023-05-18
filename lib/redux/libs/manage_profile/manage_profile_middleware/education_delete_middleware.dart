import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/education_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/education_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> eudcationDeleteMiddleware(
    {context,
    dynamic id}) {
  return (Store<AppState> store) async {


    store.dispatch(Loader.delete);

    var baseUrl = "${AppConfig.BASE_URL}/member/education/${id}";
    var accessToken = prefs.getString(Const.accessToken);


    //
    // var postBody = jsonEncode({
    //   "degree": degree,
    //   "institution": institution,
    //   "education_start": start,
    //   "education_end": end,
    // });

    try {
      var response = await http.delete(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },);

      var data = educationUpdateResponseFromJson(response.body);

      store.dispatch(Loader.delete);

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(educationGetMiddleware());

      store.dispatch(EducationUpdateResponse(
        result: data.result,
        message: data.message,
      ));


    } catch (e) {
      store.dispatch(Loader.update);

      print("error ${e.toString()}");
      return;
    }
  };
}
