import 'package:active_matrimonial_flutter_app/models_response/manage_profile/family_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/family_get_response.dart';

class FamilyState {
   FamilyInfoUpdateResponse familyInfoUpdateResponse;
   bool isloading;
   bool pageloader;
   FamilyGetResponse familyGetResponse;

  FamilyState({this.familyInfoUpdateResponse, this.isloading, this.pageloader, this.familyGetResponse});

  FamilyState.initialState()
      : familyInfoUpdateResponse = FamilyInfoUpdateResponse.initialState(),
        familyGetResponse = FamilyGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}
