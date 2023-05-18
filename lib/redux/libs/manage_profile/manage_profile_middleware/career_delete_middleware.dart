import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/career_delete_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/career_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/career_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> careerDeleteMiddleware(
    {context,
    dynamic id}) {
  return (Store<AppState> store) async {


    store.dispatch(CareerLoader.delete);

    var baseUrl = "${AppConfig.BASE_URL}/member/career/${id}";
    var accessToken = prefs.getString(Const.accessToken);




    try {
      var response = await http.delete(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },);

      var data = careerDeleteResponseFromJson(response.body);

      store.dispatch(CareerLoader.delete);

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(careerGetMiddleware());

      store.dispatch(CareerDeleteResponse(
        result: data.result,
        message: data.message,
      ));


    } catch (e) {
      store.dispatch(CareerLoader.delete);

      print("error ${e.toString()}");
      return;
    }
  };
}
