import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/present_address_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/present_update_response.dart';

class PresentAddressState {
  final PresentUpdateResponse presentUpdateResponse;
  final PresentAddressGetResponse presentAddressGetResponse;

   bool isLoading;
   bool saveChangesLoader;
  final StateResponse stateResponse;
  final CityResponse cityResponse;

  DDown selected_state;
  DDown selected_city;
  DDown selected_country;
  // set_country(country_value) {
  //   this.country_value = country_value;
  // }

  save_chagnes_toogler(){
    this.saveChangesLoader = !saveChangesLoader;
  }

  page_loader_toogler(){
    this.isLoading = !isLoading;
  }

  PresentAddressState({
    this.presentUpdateResponse,
    this.isLoading,
    this.presentAddressGetResponse,
    this.saveChangesLoader,
    this.stateResponse,
    this.cityResponse,
  });

  PresentAddressState.initialState()
      : presentUpdateResponse = PresentUpdateResponse.initialState(),
        presentAddressGetResponse = PresentAddressGetResponse.initialState(),
        stateResponse = StateResponse.initialState(),
        cityResponse = CityResponse.initialState(),
        saveChangesLoader = false,
        isLoading = false;
}
