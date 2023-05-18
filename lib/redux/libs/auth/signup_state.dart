import 'package:active_matrimonial_flutter_app/models_response/auth/signup_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/on_behalf.dart';

class SignUpState {
  SignUpState(
      {this.signUpResponse,
      this.isLoading,
      this.onbehalfResponse,});

  final SignUpResponse signUpResponse;
  bool isLoading;
  final OnbehalfResponse onbehalfResponse;



  SignUpState.initialState()
      : signUpResponse = SignUpResponse.initialState(),

        onbehalfResponse = OnbehalfResponse.initialState(),
        isLoading = false;
}
