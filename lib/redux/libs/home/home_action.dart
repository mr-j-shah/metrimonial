import 'package:active_matrimonial_flutter_app/models_response/home_response.dart';

class HomeStoreAction {
  HomeResponse payload;

  HomeStoreAction({this.payload});

  @override
  String toString() {
    return 'HomeStoreAction{payload: $payload}';
  }
}

class HomeFailureAction {
  String error;

  HomeFailureAction({this.error});

  @override
  String toString() {
    return 'HomeFailureAction{error: $error}';
  }
}

class AddToIgnoreListFromHome {
  var context;
  var user;

  @override
  String toString() {
    return 'AddToIgnoreListFromHome{context: $context, user: $user}';
  }

  AddToIgnoreListFromHome({this.user, this.context});
}
