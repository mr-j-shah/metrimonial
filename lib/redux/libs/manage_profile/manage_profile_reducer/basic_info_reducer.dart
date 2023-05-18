import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/basic_info_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/basic_Info_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/basic_info_state.dart';

class BasicInfoLoader {}
class SearchLoader {}

class PageLoader {}

class BasicReset{}
class BasicProfiledropdownResponse{
  ProfiledropdownResponseData data;
  bool result;
  BasicProfiledropdownResponse({this.data, this.result});
}

BasicInfoState basic_info_reducer(BasicInfoState state, dynamic action) {

  if (action is BasicInfoResponse) {
    return bir_basic_info_response(state, action);
  }
  if (action is BasicInfoLoader) {
    return bir_bir_loader(state, action);
  }
  if (action is PageLoader) {
    return bir_page_loader(state, action);
  }

  if (action is BasicInfoGetResponse) {
    return bir_basic_info_get_response(state, action);
  }
  if (action is BasicReset){
    return reset(state, action);
  }

  return state;
}

bir_basic_info_get_response(BasicInfoState state, BasicInfoGetResponse action) {
  state.basicInfoGetResponse.data = action.data;
  state.basicInfoGetResponse.result = action.result;

  store.state.manageProfileCombineState.profiledropdownResponseData.data.onbehalfList.forEach((element) {
    if(state.basicInfoGetResponse.data.onbehalf.id == element.id){
      state.on_behalves_value = element;
    }
  });

  store.state.manageProfileCombineState.profiledropdownResponseData.data.maritialStatus.forEach((element) {
    if(state.basicInfoGetResponse.data.maritialStatus == element.name){
      state.marital_status_value = element;
    }
  });

  return state;
}



bir_page_loader(BasicInfoState state, PageLoader action) {
  state.pageloader = !state.pageloader;
  return state;
}

bir_bir_loader(BasicInfoState state, BasicInfoLoader action) {
  state.isloading = !state.isloading;
  return state;
}

bir_basic_info_response(BasicInfoState state, BasicInfoResponse action) {
  state.basicInfoResponse.result = action.result;
  state.basicInfoResponse.message = action.message;
  return state;
}

reset(BasicInfoState state, BasicReset action){
  state = BasicInfoState.initialState();
  return state;
}


