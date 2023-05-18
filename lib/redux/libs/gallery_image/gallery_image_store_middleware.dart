import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> gallery_image_save({dynamic photo}) {
  return (Store<AppState> store) async {
    store.dispatch(ImageLoader());

    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    var pic = await http.MultipartFile.fromPath("gallery_image", photo.path);
    request.files.add(pic);

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    store.dispatch(ImageLoader());
    store.dispatch(galleryImageMiddleware());

    if (response.statusCode == 200) {
      MyScaffoldMessenger().sf_messenger(
          text: "Information Successfully saved!", color: MyTheme.success);
      store.dispatch(galleryImageMiddleware());
      store.dispatch(accountMiddleware());
    } else {
      MyScaffoldMessenger()
          .sf_messenger(text: "Something is wrong", color: MyTheme.failure);
      store.dispatch(galleryImageMiddleware());
    }
  };
}
