class MyWalletState {
  MyWalletState({
    this.isFetching,
    this.balance,
    this.balanceHistory,
    this.balanceError,
    this.historyError,
    this.hasMore,
    this.page,
  });

  bool isFetching;
  String balance;
  List balanceHistory = [];
  String balanceError;
  String historyError;
  bool hasMore;
  int page;

  MyWalletState.initialState()
      : isFetching = true,
        balance = "0.00",
        balanceError = '',
        historyError = '',
        hasMore = true,
        page = 1,
        balanceHistory = [];
}
