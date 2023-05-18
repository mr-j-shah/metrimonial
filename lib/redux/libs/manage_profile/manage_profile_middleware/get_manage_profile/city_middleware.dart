import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/present_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/search/basic_search_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> cityMiddleware(state ,AppStates appStates) {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/cities/$state";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      print(response.body);
      var data = cityResponseFromJson(response.body);
      print(data.data.first.name);

      if(appStates == AppStates.presentAddress) {
        store.dispatch(CityResponseForPresentAddress(data.data));
      }else if(appStates == AppStates.permanentAddress) {
        store.dispatch(PermanentAddressCityListAction(data.data));
      }else if(appStates == AppStates.advancedSearch){
        store.dispatch(SearchGetCityValueAction(
          data.data,
        ));
      }
      else{
        store.dispatch(CityResponse(
          data: data.data,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
