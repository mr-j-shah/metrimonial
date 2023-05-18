import 'package:active_matrimonial_flutter_app/models_response/app_info_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_state.dart';

AppInfoState app_info_reducer(AppInfoState state, dynamic action) {
  if (action is AppInfoResponse) {
    state.appInfoResponse =
        AppInfoResponse(result: action.result, data: action.data);

    return state;
  }
  if (action is AppInfoStoreAction) {
    return appinfostore(state, action);
  }
  if (action is AppInfoFailureAction) {
    state.error = action.error;
    return state;
  }
  return state;
}

appinfostore(AppInfoState state, AppInfoStoreAction action) {
  state.isFetching = false;
  state.website_name = action.data.data.websiteName;
  state.logo = action.data.data.systemLogo;
  state.title = action.data.data.howItWorksTitle;
  state.subtitle = action.data.data.howItWorksSubTitle;
  action.data.data.howItWorks.forEach((element) {
    state.list.add(
      AppInfoViewModel(
        steps: element.steps,
        icon: element.howItWorksStepsIcons,
        hwt_title: element.howItWorksStepsTitles,
        hwt_subtitle: element.howItWorksStepsSubTitles,
      ),
    );
  });
  return state;
}
