import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/express_interest_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_state.dart';

class ResetExpressInterest {}

MyInterestState my_interest_reducer(MyInterestState state, dynamic action) {
  if (action is ExpressInterestResponse) {
    return express_interest_response(state, action);
  }
  if (action is ExpressInterestAction) {
    return express_loader_toggler(state, action);
  }
  if (action is ResetExpressInterest) {
    state = MyInterestState.initialState();
    return state;
  }

  if (action is MyInterestStoreAction) {
    state.isFetching = false;

    if (action.payload.meta.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.myInterestList.addAll(action.payload.data);
    return state;
  }
  if (action is MyInterestFailureAction) {
    state.error = action.error;
    return state;
  }
  if (action == Reset.myInterestList) {
    state = MyInterestState.initialState();

    return state;
  }

  return state;
}

express_loader_toggler(MyInterestState state, ExpressInterestAction action) {
  state.isLoading = !state.isLoading;
  return state;
}

express_interest_response(
    MyInterestState state, ExpressInterestResponse action) {
  state.expressInterestResponse.result = action.result;
  state.expressInterestResponse.message = action.message;
  return state;
}
