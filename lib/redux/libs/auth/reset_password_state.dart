import 'package:active_matrimonial_flutter_app/models_response/auth/resetpassword_response.dart';

class ResetPasswordState {
  final ResetPasswordResponse resetPasswordResponse;
  bool passwordObscure;
  bool confirmPasswordObscure;
  bool rp_loader;


  ResetPasswordState({
    this.resetPasswordResponse,
    this.passwordObscure,
    this.confirmPasswordObscure,
    this.rp_loader
  });

  ResetPasswordState.initialState()
      : resetPasswordResponse = ResetPasswordResponse.initialState(),
        passwordObscure = true,
  rp_loader = false,
        confirmPasswordObscure = true;
}
