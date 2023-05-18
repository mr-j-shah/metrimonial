import 'package:active_matrimonial_flutter_app/models_response/interest/accept_interest_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/interest/reject_interest_response.dart';

import '../../../models_response/interest/interest_request_response.dart';

/// my interest state
class InterestRequestState {
  final AcceptInterestResponse acceptInterestResponse;
  final RejectInterestResponse rejectInterestResponse;
  var page;
  var index;
  bool hasMore;
  bool isLoading;
  bool isFetching;
  bool acceptInterest;

  var interestRequestList=[];
  String error;

  InterestRequestState(
      {this.page,
      this.index,
      this.acceptInterest,
      this.rejectInterestResponse,
      this.acceptInterestResponse,
      this.hasMore,
      this.isLoading,
      this.isFetching,
        this.interestRequestList,
        this.error,
      });

  InterestRequestState.initialState()
:        acceptInterestResponse = AcceptInterestResponse.initialState(),
        rejectInterestResponse = RejectInterestResponse.initialState(),
        acceptInterest = false,
        hasMore = true,
        error = '',
        interestRequestList = [],
        isLoading = false,
        isFetching = true,
        page = 1;
}
