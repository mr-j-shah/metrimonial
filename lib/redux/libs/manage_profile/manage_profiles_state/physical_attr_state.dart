import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/physical_attributes_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/physical_attr_update_response.dart';

class PhysicalAttrState {
   PhysicalAttrUpdateResponse physicalAttrUpdateResponse;
   bool isLoading;
   PhysicalAttributesGetResponse physicalAttributesGetResponse;


  PhysicalAttrState({this.physicalAttrUpdateResponse, this.isLoading, this.physicalAttributesGetResponse});

  PhysicalAttrState.initialState()
      : physicalAttrUpdateResponse = PhysicalAttrUpdateResponse.initialState(),
        physicalAttributesGetResponse = PhysicalAttributesGetResponse(),
        isLoading = false;
}
