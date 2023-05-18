import 'package:active_matrimonial_flutter_app/models_response/manage_profile/astronomic_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/astronomic_get_response.dart';

class AstronomicState {
  final AstronomicInfoUpdateResponse astronomicInfoUpdateResponse;
   bool isloading;
   bool pageloader;
  final AstronomicGetResponse astronomicGetResponse;

  AstronomicState(
      {this.astronomicInfoUpdateResponse,
      this.isloading,
      this.pageloader,
      this.astronomicGetResponse});

  AstronomicState.initialState()
      : astronomicInfoUpdateResponse =
            AstronomicInfoUpdateResponse.initialState(),
        astronomicGetResponse = AstronomicGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}
