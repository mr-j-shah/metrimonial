import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/get_support_ticket_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> supportTicketCreateMiddleware({
  dynamic subject,
  dynamic category,
  dynamic details,
  dynamic image,
}) {
  return (Store<AppState> store) async {


    store.dispatch(SupportLoader());

    var baseUrl = "${AppConfig.BASE_URL}/member/support-ticket/store";
    var accessToken =  prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);
    request.fields["subject"] = subject;
    request.fields["support_category_id"] = category;
    request.fields["description"] = details;

    var pic = await http.MultipartFile.fromPath("attachment", image.path);
    request.files.add(pic);

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    store.dispatch(SupportLoader());

    if (response.statusCode == 200) {
      MyScaffoldMessenger().sf_messenger(
          text: "Information Successfully saved!", color: MyTheme.success);

      store.dispatch(getSupportTicketMiddleware());
    } else {
      MyScaffoldMessenger()
          .sf_messenger(text: "Something is wrong", color: MyTheme.failure);
    }
  };
}
