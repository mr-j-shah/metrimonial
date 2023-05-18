import 'package:active_matrimonial_flutter_app/models_response/auth/verify_response.dart';

class VerifyState {
  final VerifyResponse verify;
  bool vloader;

  VerifyState({
    this.verify,
    this.vloader
  });

  VerifyState.initialState() : verify = VerifyResponse.initialState(), vloader = false;
}
