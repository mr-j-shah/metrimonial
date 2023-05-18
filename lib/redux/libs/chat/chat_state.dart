import 'package:active_matrimonial_flutter_app/models_response/chat/chat_response.dart';

class ChatState {
  bool isFetching;
  String error;
  List chatList = [];
  ChatResponseMatchedProfile matchedProfile;

  ChatState({
    this.matchedProfile,
    this.isFetching,
    this.error,
    this.chatList,
  });

  ChatState.initialState()
      : isFetching = true,
        error = '',
        chatList = [],
        matchedProfile = null;
}
