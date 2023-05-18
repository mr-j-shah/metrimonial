import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/education_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/education_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/education_update_response.dart';

class EducationState {
  final EducationResponse educationResponse;
   bool isLoading;
   bool saveChanges;
   final EducationGetResponse educationGetResponse;
   final EducationUpdateResponse educationUpdateResponse;
   bool update_changes;
   int index;
   int delIndex;
   bool isDelete;

  var list = <EducationViewModel>[];


  EducationState({this.delIndex, this.isDelete, this.index, this.educationResponse, this.isLoading, this.saveChanges, this.educationGetResponse, this.educationUpdateResponse, this.update_changes});

  EducationState.initialState()
      : educationResponse = EducationResponse.initialState(),
        educationGetResponse = EducationGetResponse.initialState(),
        educationUpdateResponse = EducationUpdateResponse.initialState(),
        update_changes = false,
        isLoading = false,
        isDelete = false,
        saveChanges = false;
}
