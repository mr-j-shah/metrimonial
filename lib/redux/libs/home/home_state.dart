import 'package:active_matrimonial_flutter_app/models_response/explore_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/home_response.dart';

class HomeState {

  bool isFetching;
  List homeDataList;
  String error;

  // final ExploreResponse exploreResponse;

  HomeState({
    this.error,
    this.isFetching,
    this.homeDataList,
  });

  HomeState.initialState()
      : isFetching = true,
        error = '',
        homeDataList = [];
}
