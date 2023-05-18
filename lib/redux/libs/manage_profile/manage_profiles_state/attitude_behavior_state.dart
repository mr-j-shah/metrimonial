import 'package:active_matrimonial_flutter_app/models_response/manage_profile/attitude_behaviour_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/attitude_behavior_get_response.dart';

class AttitudeBehaviorState {
   AttitudeBehaviourUpdateResponse attitudeBehaviourUpdateResponse;
   bool isLoading;
   AttitudeBehaviorGetResponse attitudeBehaviorGetResponse;


  AttitudeBehaviorState(
      {this.isLoading, this.attitudeBehaviourUpdateResponse, this.attitudeBehaviorGetResponse});

  AttitudeBehaviorState.initialState()
      : isLoading = false,
        attitudeBehaviorGetResponse = AttitudeBehaviorGetResponse.initialState(),
        attitudeBehaviourUpdateResponse =
            AttitudeBehaviourUpdateResponse.initialState();
}
