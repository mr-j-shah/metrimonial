import 'dart:convert';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/profile_picture_view_request_post_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> sendProfilePictureViewRequestAction({id}) {
  return (Store<AppState> store) async {
    try {
      CommonResponse data =
          await ProfileAndGalleryViewRequestRepository()
              .sendProfilePictureViewRequest(id: id);

      if (data.result == true) {
        store.dispatch(ProfilePictureViewRequestPostResponse(
          result: data.result,
          message: data.message,
        ));
        store.dispatch(accountMiddleware());

        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  };
}

class ProfileAndGalleryViewRequestRepository {


   Future<CommonResponse>
      sendProfilePictureViewRequest({id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/profile-picture-view-request";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({"id": id});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }


}
