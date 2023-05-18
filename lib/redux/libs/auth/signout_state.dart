import 'package:active_matrimonial_flutter_app/models_response/auth/signout_response.dart';

class SignOutState {
  final SignOutResponse signOutResponse;

  SignOutState({
    this.signOutResponse,
  });

  SignOutState.initialState()
      : signOutResponse = SignOutResponse.initialState();
}
