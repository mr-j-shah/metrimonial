import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/permanet_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/permanent_address_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> permanentAddressUpdateMiddleware(
    {context,
    dynamic country,
    dynamic state,
    dynamic city,
    dynamic postal_code}) {
  return (Store<AppState> store) async {

    print(country);
    print(state);
    print(city);

    store.dispatch(PermanentAddressSaveChanges());
    var baseUrl = "${AppConfig.BASE_URL}/member/address/update";
    var accessToken = prefs.getString(Const.accessToken);



    var postBody = jsonEncode({
      "address_type": "permanent",
      "country_id": country,
      "state_id": state,
      "city_id": city,
      "postal_code": postal_code
    });

    print(postBody);


    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = permanentUpdatetResponseFromJson(response.body);
      store.dispatch(PermanentAddressSaveChanges());
      store.dispatch(permanentAddressGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(PermanentUpdatetResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
