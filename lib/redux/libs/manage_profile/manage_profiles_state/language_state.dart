import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/language_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/language_update_response.dart';

class LanguageState {
  final LanguageUpdateResponse languageUpdateResponse;
  bool isloading;
  bool saveChangesLoader;
  final LanguageGetResponse languageGetResponse;
  DDown selectedMotherTongue;
  List<dynamic> selectedKnowLanguage=[];


 dynamic selectedKnowLanguageMap(List<DDown> list){
    return list.map((e) => {"name": e.name, "id": e.id}).toList();
  }
  /*
  List<int>getSelectedKnowLanguageIds(){
    List<int> ids=[];
    this.selectedKnowLanguage.forEach((element) {
      ids.add(element.id);
    });
     return ids;
  }*/

  LanguageState(
      {this.languageGetResponse, this.languageUpdateResponse, this.isloading, this.saveChangesLoader});

  LanguageState.initialState()
      : languageUpdateResponse = LanguageUpdateResponse.initialState(),
        isloading = false,
        languageGetResponse = LanguageGetResponse.initialState(),
        saveChangesLoader = false;
}
