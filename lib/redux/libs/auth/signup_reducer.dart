import 'package:active_matrimonial_flutter_app/models_response/addon_check_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signup_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/on_behalf.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_state.dart';

SignUpState sign_up_reducer(SignUpState state, dynamic action) {
  if (action is SignUpResponse) {
    return sign_up_response(state, action);
  }
  if (action is SignUpAction) {
    return loader(state, action);
  }

  if (action is OnbehalfResponse) {
    return on_be_half_response(state, action);
  }

  return state;
}



on_be_half_response(SignUpState state, OnbehalfResponse action) {
  state.onbehalfResponse.data = action.data;
  return state;
}

sign_up_response(SignUpState state, SignUpResponse action) {
  state.signUpResponse.result = action.result;
  state.signUpResponse.message = action.message;
  return state;
}

loader(SignUpState state, SignUpAction action) {
  state.isLoading = !state.isLoading;
  return state;
}
