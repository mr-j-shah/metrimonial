import 'package:active_matrimonial_flutter_app/models_response/forgetpassword_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/forgetpassword_state.dart';

ForgetPasswordState forgetpassword_reducer(
    ForgetPasswordState state, dynamic action) {
  if (action is ForgetPasswordResponse) {
    return forget_password_response(state, action);
  }
  if(action is FpLoader){
    return loader(state, action);
  }

  return state;
}

class FpLoader {
}


forget_password_response(ForgetPasswordState state, ForgetPasswordResponse action){
  state.forgetPassword.result = action.result;
  state.forgetPassword.message = action.message;
  return state;
}
loader(ForgetPasswordState state, FpLoader action){
  state.fp_loader =!state.fp_loader;
  return state;
}
