import 'dart:convert';
import 'package:active_matrimonial_flutter_app/const/const.dart';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/partner_expectation_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/permanet_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/present_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/partnerExpectationGetMiddleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/partner_expectation_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/present_address_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> partnerExpectationMiddleware({
  context,
  dynamic general_info,
  dynamic min_height,
  dynamic max_weight,
  dynamic residency_country,
  dynamic marital_status,
  dynamic children,
  dynamic religion,
  dynamic caste,
  dynamic subcaste,
  dynamic language,
  dynamic smoking,
  dynamic education,
  dynamic profession,
  dynamic drinking,
  dynamic diet,
  dynamic body_type,
  dynamic personal_value,
  dynamic manglik,
  dynamic pref_country,
  dynamic pref_state,
  dynamic family_val,
  dynamic complexion,
}) {
  return (Store<AppState> store) async {
    store.dispatch(Pexsave());
    var baseUrl = "${AppConfig.BASE_URL}/member/partner-expectation/update";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({
      "general": general_info,
      "partner_height": min_height,
      "partner_weight": max_weight,
      "partner_marital_status": marital_status,
      "partner_children_acceptable": children,
      "residence_country_id": residency_country,
      "partner_religion_id": religion,
      "partner_caste_id": caste,
      "partner_sub_caste_id": subcaste,
      "pertner_education": education,
      "partner_profession": profession,
      "smoking_acceptable": smoking,
      "drinking_acceptable": drinking,
      "partner_diet": diet,
      "partner_body_type": body_type,
      "partner_personal_value": personal_value,
      "partner_manglik": manglik,
      "language_id": language,
      "family_value_id": family_val,
      "partner_country_id": pref_country,
      "partner_state_id": pref_state,
      "pertner_complexion": complexion,
    });

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = partnerExpectationUpdateResponseFromJson(response.body);
      store.dispatch(Pexsave());
      store.dispatch(partnerExpectationGetMiddleware());

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      store.dispatch(PartnerExpectationUpdateResponse(
        result: data.result,
        message: data.message,
      ));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
  };
}
