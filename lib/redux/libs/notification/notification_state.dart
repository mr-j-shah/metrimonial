import 'package:active_matrimonial_flutter_app/models_response/notifications_get_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/notifications_read_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_action.dart';

class NotificationState {
  NotificationStatus notificationStatus;
  bool notification_loader;
  final ReadNotificationsResponse readNotificationsResponse;

  int page;
  bool hasMore;
  bool fetchData;
  List<NotificationData> notification_list;
  String error;

  NotificationState({
    this.notification_list,
    this.notification_loader,
    this.readNotificationsResponse,
    this.error,
    this.notificationStatus,
  });

  NotificationState.initialState()
      : notification_list = [],
        readNotificationsResponse = ReadNotificationsResponse.initialState(),
        notificationStatus= NotificationStatus.initial,
        notification_loader = true,
        fetchData = false,
        page = 1,
        error = '',
        hasMore = true;
}
