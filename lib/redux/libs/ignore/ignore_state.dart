class IgnoreState {
  bool isFetching;
  var page;
  bool hasMore;
  var ignoreList = [];
  String error;

  IgnoreState({
    this.ignoreList,
    this.error,
  });

  IgnoreState.initialState()
      : isFetching = true,
        page = 1,
        hasMore = true,
        ignoreList = [],
        error = '';
}
