import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/education_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

import '../../manage_profile_reducer/education_reducer.dart';



ThunkAction<AppState> educationGetMiddleware() {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/education";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });

      var data = educationGetResponseFromJson(response.body);
      store.dispatch(EducationReset.list);

      data.data.forEach((element) {
        store.state.manageProfileCombineState.educationState.list.add(
          EducationViewModel(
            id: element.id,
            degree_hint: 'Bachelor of Arts',
            institute_hint: 'Middlebury College',
            start_hint: '2016',
            end_hint: '2023',
            present: element.present,
            degree_controller: TextEditingController(text: element.degree),
            institute_controller: TextEditingController(text: element.institution),
            start_controller: TextEditingController(text: element.start.toString()),
            end_controller: TextEditingController(text: element.end.toString()),

          ),
        );
      });
      store
          .dispatch(EducationGetResponse(data: data.data, result: data.result));
    } catch (e) {
      print("error education get middleware ${e.toString()}");
      return;
    }
  };
}
