

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/career_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/career_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


ThunkAction<AppState> careerGetMiddleware() {
  return (Store<AppState> store) async {


    var baseUrl = "${AppConfig.BASE_URL}/member/career";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = careerGetResponseFromJson(response.body);
      store.dispatch(CareerReset.careeer_list);

      data.data.forEach((element) {
        store.state.manageProfileCombineState.careerState.list.add(
          CareerViewModel(
            designation_text: 'Designation',
            id: element.id,
            present: element.present,
            company_text: 'Company',
            start: '2016',
            end: '2023',
            designation_controller: TextEditingController(text: element.designation),
            company_controller: TextEditingController(text: element.company),
            start_controller: TextEditingController(text: element.start.toString()),
            end_controller: TextEditingController(text: element.end.toString()),

          ),
        );
      });


      store.dispatch(CareerGetResponse(data: data.data, result: data.result));
    } catch (e) {
      // debugPrint(e.toString());
      print("error career get middleware ${e.toString()}");
      return;
    }
  };
}
