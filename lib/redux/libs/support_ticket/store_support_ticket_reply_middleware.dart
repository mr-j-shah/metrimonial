
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/get_support_ticket_middleware.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> storeSupportTicketReplyMiddleware(
    {ticket_id, reply, attachment}) {
  return (Store<AppState> store) async {
    // print(ticket_id);
    // print(reply);
    // print(attachment);

    var baseUrl = "${AppConfig.BASE_URL}/member/ticket-reply";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields["support_ticket_id"] = ticket_id.toString();
    request.fields["reply"] = reply;

    var pic = await http.MultipartFile.fromPath("attachment", attachment.path);
    request.files.add(pic);
    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();

    print('############################ ok ###############');

      store.dispatch(getSupportTicketMiddleware());
  };
}
