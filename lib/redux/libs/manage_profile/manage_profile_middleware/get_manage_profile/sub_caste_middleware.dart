import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/partner_expectation_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> subcasteMiddleware(caste, {AppStates appStates}) {
  return (Store<AppState> store) async {

    var baseUrl = "${AppConfig.BASE_URL}/member/sub-casts/$caste";
    var accessToken = prefs.getString(Const.accessToken);



    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = subcasteResponseFromJson(response.body);

      if(appStates==AppStates.partnerPreference){
        store.dispatch(PartnerPrefSubCasteResponse(
          data: data.data,
        ));
      }else {
        store.dispatch(SubcasteResponse(
          data: data.data,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
