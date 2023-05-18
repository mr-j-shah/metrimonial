import 'package:active_matrimonial_flutter_app/models_response/app_info_response.dart';

class AppInfoState {
  AppInfoResponse appInfoResponse;
  var website_name;
  var logo;
  var title;
  var subtitle;
  var list = [];
  String error;
  bool isFetching;

  AppInfoState({
    this.appInfoResponse,
    this.list,
    this.isFetching,
    this.logo,
    this.error,
    this.website_name,
    this.title,
    this.subtitle,
  });

  AppInfoState.initialState()
      : list = [],
        isFetching = true,
        error = '';
}

class AppInfoViewModel {
  AppInfoViewModel({
    this.icon,
    this.steps,
    this.hwt_title,
    this.hwt_subtitle,
  });

  final icon;
  final steps;
  final hwt_title;
  final hwt_subtitle;
}
