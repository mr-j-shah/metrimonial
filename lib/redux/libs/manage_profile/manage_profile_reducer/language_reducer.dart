import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/language_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/language_update_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/language_state.dart';

class LanguageLoader {}

class LanguageSaveChanges {}
class GetLanguageListAction {
  List<DDown> languageList;

  GetLanguageListAction(this.languageList);
}

LanguageState language_reducer(LanguageState state, dynamic action) {
  if (action is LanguageUpdateResponse) {
    return language_update_response(state, action);
  }
  if (action is LanguageLoader) {
    return language_loader(state, action);
  }
  if (action is LanguageSaveChanges) {
    return language_save_changes_loader(state, action);
  }
  if (action is LanguageGetResponse) {
    return language_get_response(state, action);
  }
  return state;
}

language_update_response(LanguageState state, LanguageUpdateResponse action) {
  state.languageUpdateResponse.message = action.message;
  state.languageUpdateResponse.result = action.result;
  return state;
}

language_get_response(LanguageState state, LanguageGetResponse action) {
  state.languageGetResponse.data = action.data;
  state.languageGetResponse.result = action.result;
  return state;
}

language_loader(LanguageState state, LanguageLoader action) {
  state.isloading = !state.isloading;
  return state;
}

language_save_changes_loader(LanguageState state, LanguageSaveChanges action) {
  state.saveChangesLoader = !state.saveChangesLoader;
  return state;
}
