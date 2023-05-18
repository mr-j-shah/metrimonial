class ReferralState {
  String referralCode;
  int page;
  bool isFetching;
  bool hasMore;
  var referralUserList = [];
  String error;
  String referralCodeError;

  ReferralState({
    this.page,
    this.isFetching,
    this.referralCode,
    this.hasMore,
    this.referralUserList,
    this.error,
    this.referralCodeError,
  });

  ReferralState.initialState()
      : page = 1,
        referralCodeError = '',
        referralCode = '--------',
        hasMore = true,
        isFetching = true,
        referralUserList = [],
        error = '';
}
