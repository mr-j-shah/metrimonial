import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';

class ShowMessageState {
  ShowMessageState.initialState();
}

class ShowMessageAction {
  var msg;
  var color;
  ShowMessageAction({this.msg, this.color});
}

ShowMessageState show_message_reducer(ShowMessageState state, dynamic action) {
  if (action is ShowMessageAction) {
    return show_message(state, action);
  }
  return state;
}

show_message(ShowMessageState state, dynamic action) {
  MyScaffoldMessenger().sf_messenger(text: action.msg, color: action.color);
}
