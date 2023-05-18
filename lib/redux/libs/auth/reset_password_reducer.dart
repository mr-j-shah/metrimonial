import 'package:active_matrimonial_flutter_app/models_response/auth/resetpassword_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_state.dart';

enum ResetPasswordActions { passwordObscure, confirmPasswordObscure }

ResetPasswordState reset_password_reducer(
    ResetPasswordState state, dynamic action) {
  if (action is ResetPasswordResponse) {
    return reset_password_response(state, action);
  }
  if (action == ResetPasswordActions.passwordObscure) {
    return password_obscure(state, action);
  }

  if (action == ResetPasswordActions.confirmPasswordObscure) {
    return confirm_password_obscure(state, action);
  }
  if (action is RpLoader) {
    return loader(state, action);
  }
  if (action is RpReset) {
    return reset(state, action);
  }

  return state;
}

reset(ResetPasswordState state, RpReset action) {
  state = ResetPasswordState.initialState();
  return state;
}

reset_password_response(
    ResetPasswordState state, ResetPasswordResponse action) {
  state.resetPasswordResponse.result = action.result;
  state.resetPasswordResponse.message = action.message;
  return state;
}

password_obscure(ResetPasswordState state, dynamic action) {
  state.passwordObscure = !state.passwordObscure;
  return state;
}

confirm_password_obscure(ResetPasswordState state, dynamic action) {
  state.confirmPasswordObscure = !state.confirmPasswordObscure;
  return state;
}

loader(ResetPasswordState state, RpLoader action) {
  state.rp_loader = !state.rp_loader;
  return state;
}

class RpLoader {}

class RpReset {}
