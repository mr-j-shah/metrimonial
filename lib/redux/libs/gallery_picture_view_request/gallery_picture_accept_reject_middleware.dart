import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> getGalleryPictureAcceptRejectMiddleware(
    {ctx, isAcceptReject, id}) {
  return (Store<AppState> store) async {
    print(isAcceptReject);
    print(id);

    var baseUrl =
        "${AppConfig.BASE_URL}/member/gallery-image-view-request/$isAcceptReject";
    var accessToken = prefs.getString(Const.accessToken);

    var postBody = jsonEncode({"gallery_image_view_request_id": id});

    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          body: postBody);

      var data = commonResponseFromJson(response.body);

      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      if (data.result == true) {
        store.dispatch(GalleryPicture.reloadlist);
      }


      // store
      //     .dispatch(CommonResponse(message: data.message, result: data.result));
    } catch (e) {
      print(
          "error get gallery picture view accept or reject middleware ${e.toString()}");
      return;
    }
  };
}
