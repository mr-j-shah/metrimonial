import 'package:active_matrimonial_flutter_app/models_response/account_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_action.dart';
import 'package:active_matrimonial_flutter_app/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> accountMiddleware() {
  return (Store<AppState> store) async {

    try {
      var data = await AccountRepository().fetchAccountInfo();
      store.dispatch(AccountInfoStoreAction(payload: data));
    } catch (e) {
      store.dispatch(AccountFailureAction(error: e.toString()));
      debugPrint(e);
      return;
    }
  };
}
