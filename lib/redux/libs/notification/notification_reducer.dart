import 'package:active_matrimonial_flutter_app/models_response/notifications_read_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_state.dart';

NotificationState notification_reducer(
    NotificationState state, dynamic action) {
  if (action is ReadNotificationsResponse) {
    return read_notification_response(state, action);
  }
  if (action is NotificationReset) {
    return reset(state, action);
  }
  if (action is StoreNotification) {
    store_notification(state, action);
  }if(action is NotificationFailureAction){
    state.notificationStatus = NotificationStatus.failure;
    state.error= action.error;
    return state;
  }
  return state;
}

store_notification(NotificationState state, StoreNotification action) {
  state.notification_loader = false;
  if (action.payload.meta.lastPage != state.page) {
    state.page += 1;
  } else {
    state.hasMore = false;
  }
  state.notification_list.addAll(action.payload.data);
  return state;
}

read_notification_response(
    NotificationState state, ReadNotificationsResponse action) {
  state.readNotificationsResponse.result = action.result;
  state.readNotificationsResponse.message = action.message;
  return state;
}

reset(NotificationState state, NotificationReset action) {
  state = NotificationState.initialState();
  return state;
}
