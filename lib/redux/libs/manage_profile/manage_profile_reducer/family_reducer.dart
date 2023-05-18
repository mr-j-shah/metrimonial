import 'package:active_matrimonial_flutter_app/models_response/manage_profile/family_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/family_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/family_state.dart';

class Loader {}

class FamilySaveChanges {}

FamilyState family_reducer(FamilyState state, dynamic action) {
  if (action is FamilyInfoUpdateResponse) {
    state.familyInfoUpdateResponse = FamilyInfoUpdateResponse(
        result: action.result, message: action.message);
    return state;
  }
  if (action is Loader) {
    state.isloading = !state.isloading;
    return state;
  }
  if (action is FamilySaveChanges) {
    state.pageloader = !state.pageloader;
    return state;
  }

  if (action is FamilyGetResponse) {
    state.familyGetResponse =
        FamilyGetResponse(data: action.data, result: action.result);

    return state;
  }

  return state;
}
