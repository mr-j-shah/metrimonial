import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/basic_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/basic_Info_get_response.dart';
import 'package:flutter/material.dart';

class BasicInfoState {
  final BasicInfoResponse basicInfoResponse;
  final BasicInfoGetResponse basicInfoGetResponse;
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController =
  TextEditingController();
  TextEditingController no_childController =
  TextEditingController();

  TextEditingController phoneController = TextEditingController();

 List<String> gender_items = ['Male', 'Female'];
   bool isloading;
   bool pageloader;
   DDown marital_status_value;
   DDown on_behalves_value;
   String gendervalue="Male";


  BasicInfoState({this.basicInfoGetResponse,
    this.basicInfoResponse, this.isloading,
    this.pageloader});

  BasicInfoState.initialState()
      :
        basicInfoResponse = BasicInfoResponse.intialState(),
        basicInfoGetResponse = BasicInfoGetResponse.initialState(),
        isloading = false,
        pageloader = false;
}
