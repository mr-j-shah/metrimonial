import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/life_style_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/life_style_update_response.dart';
import 'package:flutter/material.dart';

class LifeStyleState {
   LifeStyleUpdateResponse lifeStyleUpdateResponse;
   bool isLoading;
   bool saveChanges;
   LifeStyleGetResponse lifeStyleGetResponse;
   TextEditingController living_withController =
   TextEditingController(text: '');
   // country
   var items = ['Yes', 'No'];
   var diet_value = 'Yes';

   var drink_value = 'Yes';
   var smoke_value = 'No';

  LifeStyleState(
      {this.lifeStyleUpdateResponse,
      this.isLoading,
      this.saveChanges,
      this.lifeStyleGetResponse});

  update({
    lifeStyleUpdateResponse,
    isLoading,
    saveChanges,
    lifeStyleGetResponse}){
  return LifeStyleState (lifeStyleGetResponse:lifeStyleGetResponse??this.lifeStyleGetResponse,
      isLoading:isLoading??this.isLoading,
    saveChanges:saveChanges??this.saveChanges,
    lifeStyleUpdateResponse:lifeStyleUpdateResponse??this.lifeStyleUpdateResponse,
    );

  }

  LifeStyleState.initialState()
      : lifeStyleUpdateResponse = LifeStyleUpdateResponse.initialState(),
        lifeStyleGetResponse = LifeStyleGetResponse.initialState(),
        isLoading = false,
        saveChanges = false;
}
