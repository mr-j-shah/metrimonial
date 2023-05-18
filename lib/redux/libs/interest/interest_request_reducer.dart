import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/accept_interest_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/interest_request_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/reject_interest_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/reject_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_state.dart';


InterestRequestState interest_request_reducer(
    InterestRequestState state, dynamic action) {

  if (action is AcceptInterestResponse) {
    return accept_interest_resposne(state, action);
  }
  if (action is RejectInterestResponse) {
    return reject_interest_resposne(state, action);
  }
  if (action is RemoveItem) {
    return remove_interest_requests_item(state, action);
  }
  if(action ==  AcceptRejectActions.accept){
    return accept(state, action);
  }

  if (action is InterestRequestStoreAction) {
    state.isFetching = false;
    if (action.payload.meta.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.interestRequestList.addAll(action.payload.data);
    return state;
  }
  if (action is MyInterestFailureAction) {
    state.error = action.error;
    return state;
  }
  if (action == Reset.interestRequestList) {
    state = InterestRequestState.initialState();
    return state;
  }

  return state;
}



accept(InterestRequestState state,  dynamic action){
  state.acceptInterest = !state.acceptInterest;
  return state;
}

remove_interest_requests_item(InterestRequestState state, RemoveItem action) {
  state.interestRequestList.remove(action.item);
  store.dispatch(
      rejectInterestMiddleware(ctx: action.context, userId: action.item.id));
  return state;
}

reject_interest_resposne(
    InterestRequestState state, RejectInterestResponse action) {
  state.rejectInterestResponse.result = action.result;
  state.rejectInterestResponse.message = action.message;
  return state;
}

accept_interest_resposne(
    InterestRequestState state, AcceptInterestResponse action) {
  state.acceptInterestResponse.message = action.message;
  state.acceptInterestResponse.result = action.result;
  return state;
}


interest_loader_toggler(
    InterestRequestState state, InterestRequestLoadAction action) {
  state.isLoading = !state.isLoading;
  return state;
}

