import 'package:active_matrimonial_flutter_app/models_response/package/packge_details_response.dart';

class PackageDetailsState {
  PackageDetails data;
  String error;
  bool isFetching;

  PackageDetailsState.initialState()
      : data = null,
        error = '',
        isFetching = true;

  PackageDetailsState({
    this.data,
    this.error,
    this.isFetching,
  });
}
