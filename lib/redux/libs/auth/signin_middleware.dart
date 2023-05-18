import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> signInMiddleware({email, password, from}) {
  return (Store<AppState> store) async {
    store.dispatch(SignInAction(from: from));

    try {
      var data =
          await AuthRepository().signIn(email: email, password: password);
      store.dispatch(SignInAction(from: from));

      // if (data.result == true) {
      MyScaffoldMessenger().sf_messenger(
          text: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure);

      prefs.setBool(Const.prefIsLogin, true);

      store.dispatch(
        SignInResponse(
            result: data.result,
            message: data.message,
            accessToken: data.accessToken,
            tokenType: data.tokenType,
            expiresAt: data.expiresAt,
            user: data.user),
      );

      prefs.setString(Const.accessToken, data.accessToken);
      prefs.setString(Const.userName, data.user.name);
      prefs.setString(Const.maritalStatus, data.user.maritalStatusId.name);
      prefs.setInt(Const.userId, data.user.id);
      prefs.setString(Const.userHeight, data.user.height.toString());
      prefs.setString(Const.userAge, data.user.birthday.toString());
      prefs.setString(Const.userEmail,
          data.user.email == null ? data.user.phone : data.user.email);

      store.dispatch(homeMiddleware());
      OneContext().navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Main()), (route) => false);
    } catch (e) {
      debugPrint(" error find in  ${e.toString()}");

      return;
    }
  };
}
