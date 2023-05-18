import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/basic_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/basic_info_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/basic_info_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';

ThunkAction<AppState> basicInfoMiddleware(
    {context,
    dynamic f_name,
    dynamic l_name,
    dynamic gender,
    dynamic dob,
    dynamic phone,
    dynamic onbehalf,
    dynamic m_status,
    dynamic noofChild,
    dynamic photo}) {
  return (Store<AppState> store) async {
    store.dispatch(BasicInfoLoader());

    var baseUrl = "${AppConfig.BASE_URL}/member/basic-info/update";
    var accessToken = prefs.getString(Const.accessToken);

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);
    print(dob);

    request.fields["first_name"] = f_name;
    request.fields["last_name"] = l_name;
    request.fields["gender"] = '$gender';
    request.fields["date_of_birth"] = dob;
    request.fields["phone"] = phone;
    if(onbehalf!=null)
    request.fields["on_behalf"] = "$onbehalf";
    if(m_status!=null)
    request.fields["marital_status"] = m_status.toString();
    request.fields["children"] = noofChild;

    if(photo != null) {
      var pic = await http.MultipartFile.fromPath("photo", photo?.path ?? '');
      request.files.add(pic);
    }

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    store.dispatch(BasicInfoLoader());
    store.dispatch(basicInfoGetMiddleware());

    if (response.statusCode == 200) {
      MyScaffoldMessenger().sf_messenger(
          text: "Information Successfully saved!", color: MyTheme.success);
    } else {
     var message = await response.stream.bytesToString();
     print(message);
      MyScaffoldMessenger()
          .sf_messenger(text: message, color: MyTheme.failure);
    }
  };
}
