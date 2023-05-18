
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/explore_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/home_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/add_ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_state.dart';

HomeState home_reducer(HomeState state, action) {
  if(action is AddToIgnoreListFromHome){
    return add_to_ignore(state, action);
  }

  if(action is HomeStoreAction){
    state.isFetching = false;
    state.homeDataList = action.payload.data;
    return state;
  }

  if(action is HomeFailureAction){
    state.error = action.error;
    return state;
  }

  return state;
}


add_to_ignore(HomeState state, AddToIgnoreListFromHome action){
  store.dispatch(
      addIgnoreMiddleware( user: action.user));
  state.homeDataList.remove(action.user);

  return state;
}
