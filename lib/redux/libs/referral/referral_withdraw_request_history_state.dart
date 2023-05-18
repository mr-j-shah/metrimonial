class ReferralWithdrawRequestHistoryState {
  int page;
  bool isFetching;
  bool hasMore;
  var referralWithdrawRequestHistoryList = [];
  String error;

  ReferralWithdrawRequestHistoryState({
    this.page,
    this.isFetching,
    this.hasMore,
    this.referralWithdrawRequestHistoryList,
    this.error,
  });

  ReferralWithdrawRequestHistoryState.initialState()
      : page = 1,
        isFetching = true,
        hasMore = true,
        referralWithdrawRequestHistoryList = [],
        error = '';

  @override
  String toString() {
    return 'ReferralWithdrawRequestHistoryState{page: $page, isFetching: $isFetching, hasMore: $hasMore, referralWithdrawRequestHistoryList: $referralWithdrawRequestHistoryList, error: $error}';
  }
}
