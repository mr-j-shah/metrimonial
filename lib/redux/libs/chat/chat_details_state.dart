class ChatDetailsState {
  var chatDetailsList;
  bool isFetching;
  String error;

  ChatDetailsState({this.chatDetailsList, this.isFetching, this.error});

  @override
  String toString() {
    return 'ChatDetailsState{chatDetailsList: $chatDetailsList, isFetching: $isFetching, error: $error}';
  }

  ChatDetailsState.initialState()
      : chatDetailsList = [],
        isFetching = true,
        error = '';
}
