import 'package:active_matrimonial_flutter_app/models_response/manage_profile/attitude_behaviour_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/attitude_behavior_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/attitude_behavior_state.dart';

class AttitudeBehaviorLoader {}

AttitudeBehaviorState attitude_behavior_reducer(
    AttitudeBehaviorState state, dynamic action) {
  if (action is AttitudeBehaviourUpdateResponse) {
    state.attitudeBehaviourUpdateResponse = AttitudeBehaviourUpdateResponse(
        result: action.result, message: action.message);
    return state;
  }
  if (action is AttitudeBehaviorLoader) {
    state.isLoading = !state.isLoading;
    return state;
  }

  if (action is AttitudeBehaviorGetResponse) {
    state.attitudeBehaviorGetResponse =
        AttitudeBehaviorGetResponse(data: action.data, result: action.result);
  }
  return state;
}
