import 'package:active_matrimonial_flutter_app/models_response/account_response.dart';

class AccountState {
  ProfileData profileData;
  String error;

  @override
  String toString() {
    return 'AccountState{profileData: $profileData, error: $error}';
  }

  AccountState({
    this.error,
    this.profileData,
  });

  AccountState.initialState()
      : profileData = null,
        error = '';
}
