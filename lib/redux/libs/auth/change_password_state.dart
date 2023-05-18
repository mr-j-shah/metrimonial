import 'package:active_matrimonial_flutter_app/models_response/auth/change_password_response.dart';
import 'package:flutter/material.dart';

class ChangePasswordState {
  final ChangePasswordResponse changePasswordResponse;
  bool cp_loader;
  bool oldpass;
  bool newpass;
  bool confirmpass;


  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  ChangePasswordState.initialState() :
        changePasswordResponse = ChangePasswordResponse.initialState(),
        oldpass = false,
        newpass = false,
        confirmpass = false,
        cp_loader = false;
}
