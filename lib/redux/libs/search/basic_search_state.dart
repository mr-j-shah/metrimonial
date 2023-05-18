import 'package:active_matrimonial_flutter_app/models_response/drop_down/caste.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/city.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/state.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/subcaste.dart';
import 'package:active_matrimonial_flutter_app/models_response/search/basic_search_response/basic_search_response.dart';

class BasicSearchState {
  final BasicSearchResponse basicSearchResponse;

  final CasteResponse casteResponse;
  final SubcasteResponse subcasteResponse;

  final StateResponse stateResponse;
  final CityResponse cityResponse;

  var religion_value;
  var caste_value;
  var sub_caste_value;

  var country_value;
  var state_value;
  var city_value;
  var mother_tongue;
  bool search_loader;

  BasicSearchState(
      {
      this.basicSearchResponse,
      this.casteResponse,
      this.subcasteResponse,
      this.stateResponse,
      this.cityResponse});

  BasicSearchState.initialState()
      :
        casteResponse = CasteResponse.initialState(),
        subcasteResponse = SubcasteResponse.initialState(),
        search_loader = false,
        stateResponse = StateResponse.initialState(),
        cityResponse = CityResponse.initialState(),
        basicSearchResponse = BasicSearchResponse.initialState();
}
