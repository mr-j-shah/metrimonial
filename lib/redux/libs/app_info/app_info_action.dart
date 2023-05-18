class AppInfoFailureAction{
  String error;

  AppInfoFailureAction({this.error});

  @override
  String toString() {
    return 'AppInfoFailureAction{error: $error}';
  }
}

class AppInfoStoreAction {
  var data;

  @override
  String toString() {
    return 'AppInfoStoreAction{data: $data}';
  }

  AppInfoStoreAction({this.data});
}