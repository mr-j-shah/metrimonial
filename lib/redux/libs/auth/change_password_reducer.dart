import 'package:active_matrimonial_flutter_app/models_response/auth/change_password_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_state.dart';

enum obscure { oldpass, newpass, confirmpass }

ChangePasswordState change_password_reducer(
    ChangePasswordState state, dynamic action) {
  if (action is CpLoader) {
    return loader(state, action);
  }
  if (action is ChangePasswordResponse) {
    return change_password_response(state, action);
  }



  if (action == obscure.oldpass) {
    print('old --------->>>');
    state.oldpass = !state.oldpass;
    return state;
  }
  if (action == obscure.newpass) {
    print('new--------->>>');

    state.newpass = !state.newpass;
    return state;
  }
  if (action == obscure.confirmpass) {
    print('confirm --------->>>');

    state.confirmpass = !state.confirmpass;
    return state;
  }

  return state;
}

change_password_response(
    ChangePasswordState state, ChangePasswordResponse action) {
  state.changePasswordResponse.result = action.result;
  state.changePasswordResponse.message = action.message;
  return state;
}

loader(ChangePasswordState state, CpLoader action) {
  state.cp_loader = !state.cp_loader;
  return state;
}

class CpLoader {}
