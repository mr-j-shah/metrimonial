import 'package:active_matrimonial_flutter_app/models_response/auth/signout_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_state.dart';

SignOutState sign_out_reducer(SignOutState state, dynamic action) {
  if (action is SignOutResponse) {
    return sign_out_response(state, action);
  }
  return state;
}

sign_out_response(SignOutState state, SignOutResponse action) {
  state.signOutResponse.result = action.result;
  state.signOutResponse.message = action.message;
  return state;
}
