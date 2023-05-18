import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/physical_attributes_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/physical_attr_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/physical_attr_state.dart';

class PhysicalAttrLoader {}

PhysicalAttrState physical_attr_reducer(
    PhysicalAttrState state, dynamic action) {
  if (action is PhysicalAttrUpdateResponse) {
    state.physicalAttrUpdateResponse = PhysicalAttrUpdateResponse(
        result: action.result, message: action.message);

    return state;
  }
  if (action is PhysicalAttrLoader) {
    state.isLoading = !state.isLoading;
    return state;
  }

  if (action is PhysicalAttributesGetResponse) {
    state.physicalAttributesGetResponse =
        PhysicalAttributesGetResponse(data: action.data, result: action.result);
    return state;
  }

  return state;
}
