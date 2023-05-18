import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/introduction_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/introduction_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/introduction_state.dart';

class IntroLoader {}

class pageLoader {}

IntroductionState introduction_reducer(IntroductionState state, action) {
  if (action is IntroductionUpdateResponse) {
    state.introductionUpdateResponse = IntroductionUpdateResponse(
        result: action.result, message: action.message);

    return state;
  }

  if (action is IntroLoader) {
    state.isLoading = !state.isLoading;
    return state;
  }
  if (action is pageLoader) {
    state.pageLoader = !state.pageLoader;
    return state;
  }

  if (action is IntroductionGetResponse) {
    state.introductionGetResponse =
        IntroductionGetResponse(data: action.data, result: action.result);
    return state;
  }

  return state;
}
