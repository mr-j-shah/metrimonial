import 'package:active_matrimonial_flutter_app/models_response/auth/verify_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/vertify_state.dart';

VerifyState verify_reducer(VerifyState state, dynamic action) {
  if (action is VerifyResponse) {
    return verify_response(state, action);
  }

  if (action is VLoader) {
    return loader(state, action);
  }
  return state;
}

class VLoader {}

verify_response(VerifyState state, VerifyResponse action) {
  state.verify.result = action.result;
  state.verify.message = action.message;
  return state;
}

loader(VerifyState state, VLoader action) {
  state.vloader = !state.vloader;
  return state;
}
