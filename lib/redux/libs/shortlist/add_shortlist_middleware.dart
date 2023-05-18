import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/add_shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> addShortlistMiddleware({int userId}) {
  return (Store<AppState> store) async {
    store.dispatch(LoadAction());
    var baseUrl = "${AppConfig.BASE_URL}/member/add-to-shortlist";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({"user_id": userId});
    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = addShortlistResponseFromJson(response.body);
      store.dispatch(LoadAction());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);
      // print(data.result);

      if (data.result == true) {
        store.dispatch(
          AddShortlistResponse(
            result: data.result,
            message: data.message,
          ),
        );
      }
    } catch (e) {
      print('adding shortlist error $e');
      return;
    }
  };
}
