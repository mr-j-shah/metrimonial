import 'package:active_matrimonial_flutter_app/models_response/forgetpassword_response.dart';

class ForgetPasswordState {
  final ForgetPasswordResponse forgetPassword;

  bool fp_loader;

  ForgetPasswordState({this.forgetPassword, this.fp_loader});

  ForgetPasswordState.initialState()
      : forgetPassword = ForgetPasswordResponse.initialState(),
        fp_loader = false;
}
