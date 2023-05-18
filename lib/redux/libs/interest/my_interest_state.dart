import 'package:active_matrimonial_flutter_app/models_response/interest/express_interest_response.dart';

/// my interest state
class MyInterestState {
  final ExpressInterestResponse expressInterestResponse;
  bool isLoading;

  // new
  var page;
  bool hasMore;
  bool isFetching;
  var myInterestList = [];
  String error;
  bool fullReset;

  MyInterestState({
    this.page,
    this.fullReset,
    this.hasMore,
    this.error,
    this.isFetching,
    this.myInterestList,
    this.isLoading,
    this.expressInterestResponse,
  });

  MyInterestState.initialState()
      : expressInterestResponse = ExpressInterestResponse.initialState(),
        page = 1,
        error = '',
        fullReset = false,
        isFetching = true,
        myInterestList = [],
        hasMore = true,
        isLoading = false;
}
