import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/introduction_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/introduction_update_response.dart';

class IntroductionState {
   IntroductionUpdateResponse introductionUpdateResponse;
   bool isLoading;
   bool pageLoader;
   IntroductionGetResponse introductionGetResponse;

  IntroductionState(
      {this.introductionUpdateResponse,
      this.isLoading,
      this.pageLoader,
      this.introductionGetResponse});

  IntroductionState.initialState()
      : introductionUpdateResponse = IntroductionUpdateResponse.initialState(),
        introductionGetResponse = IntroductionGetResponse.initialState(),
        pageLoader = false,
        isLoading = false;
}
