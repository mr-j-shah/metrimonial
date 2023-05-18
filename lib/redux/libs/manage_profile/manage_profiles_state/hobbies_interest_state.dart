import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/hobbies_interest_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/hobbies_interest_update_response.dart';
import 'package:flutter/material.dart';

class HobbiesInterestState {
   HobbiesInterestUpdateResponse hobbiesInterestUpdateResponse;
   bool isLoading;
   HobbiesInterestGetResponse hobbiesInterestGetResponse;
  TextEditingController hobbies = TextEditingController(text: "");
  TextEditingController interests = TextEditingController(text: '');
  TextEditingController music = TextEditingController(text: '');
  TextEditingController books = TextEditingController(text: '');

  TextEditingController movies = TextEditingController(text: '');
  TextEditingController tv_shows = TextEditingController(text: '');
  TextEditingController sports = TextEditingController(text: '');
  TextEditingController fitness_activites =
  TextEditingController(text: '');
  TextEditingController cuisines = TextEditingController(text: '');
  TextEditingController dress_styles =
  TextEditingController(text: '');



  HobbiesInterestState(
      {this.hobbiesInterestGetResponse,
      this.isLoading,
      this.hobbiesInterestUpdateResponse});

  HobbiesInterestState.initialState()
      : isLoading = false,
        hobbiesInterestGetResponse = HobbiesInterestGetResponse.initialState(),
        hobbiesInterestUpdateResponse =
            HobbiesInterestUpdateResponse.initialState();
}
