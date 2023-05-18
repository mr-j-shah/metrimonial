import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/residency_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/residency_info_response.dart';

class ResidencyState {
  final ResidencyInfoUpdateResponse residencyInfoUpdateResponse;
  bool isloading;
  bool pageloader;
  final ResidencyGetResponse residencyGetResponse;

  ResidencyState(
      {this.residencyGetResponse,
      this.residencyInfoUpdateResponse,
      this.isloading,
      this.pageloader});

  ResidencyState.initialState()
      : residencyInfoUpdateResponse =
            ResidencyInfoUpdateResponse.initialState(),
        residencyGetResponse = ResidencyGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}
