class ReferralEarningState {
  int page;
  bool hasMore;
  bool isFetching;
  var referralEarningList = [];
  String error;

  ReferralEarningState({
    this.page,
    this.hasMore,
    this.isFetching,
    this.referralEarningList,
    this.error,
  });

  @override
  String toString() {
    return 'ReferralEarningState{page: $page, hasMore: $hasMore, isFetching: $isFetching, referralEarningList: $referralEarningList, error: $error}';
  }

  ReferralEarningState.initialState()
      : page = 1,
        hasMore = true,
        isFetching = true,
        referralEarningList = [],
        error = '';
}
