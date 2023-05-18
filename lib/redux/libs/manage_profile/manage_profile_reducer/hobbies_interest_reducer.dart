import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/hobbies_interest_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/hobbies_interest_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/hobbies_interest_state.dart';

class HobbiesInterestLoader {}

HobbiesInterestState hobbies_interest_reducer(
    HobbiesInterestState state, dynamic action) {
  if (action is HobbiesInterestUpdateResponse) {
    state.hobbiesInterestUpdateResponse = HobbiesInterestUpdateResponse(
        result: action.result, message: action.message);
    return state;

  }
  if (action is HobbiesInterestLoader) {
     state.isLoading= !state.isLoading;
     return state;
  }

  if (action is HobbiesInterestGetResponse) {
     state.hobbiesInterestGetResponse=
            HobbiesInterestGetResponse(data: action.data, result: action.result);
     return state;
  }
  return state;
}
