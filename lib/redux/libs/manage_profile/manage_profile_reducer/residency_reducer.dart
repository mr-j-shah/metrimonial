import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/residency_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/residency_info_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/residency_state.dart';


class Isloading {}

class ResidencySaveChanges {}

enum empty {birthCountry, residencyCountry, growupCountry}

ResidencyState residency_reducer(ResidencyState state, dynamic action) {
  if (action is ResidencyInfoUpdateResponse) {
    return residency_info_update_response(state, action);
  }
  if (action is IsLoading) {
    return is_loading(state, action);
  }
  if (action is ResidencySaveChanges) {
    return residency_save_changes(state, action);
  }
  if (action is ResidencyGetResponse) {
    return residency_get_response(state, action);
  }
  // if(action == empty.birthCountry){
  //   return empty_birth_country(state, action);
  // }
  return state;
}

// empty_birth_country(ResidencyState state, dynamic action){
//   state.res.data.
// }



residency_info_update_response(
    ResidencyState state, ResidencyInfoUpdateResponse action) {
  state.residencyInfoUpdateResponse.result = action.result;
  state.residencyInfoUpdateResponse.message = action.message;
  return state;
}

is_loading(ResidencyState state, IsLoading action) {
  state.isloading = !state.isloading;
  return state;
}

residency_save_changes(ResidencyState state, ResidencySaveChanges action) {
  state.pageloader = !state.pageloader;
  return state;
}

residency_get_response(ResidencyState state, ResidencyGetResponse action) {
  state.residencyGetResponse.result = action.result;
  state.residencyGetResponse.data = action.data;
  return state;
}
