import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/notification/notification_read_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.dispatch(NotificationReset());
    store.dispatch(notificationGetMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.notificationState.hasMore) {
          store.dispatch(notificationGetMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<String> items = ['Mark all as read'];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      // onWillChange: (_ViewModel prev, _ViewModel current) {
      //   if (current.status == NotificationStatus.failure) {
      //     OneContext().showDialog(
      //       builder: (context) {
      //         return AlertDialog(
      //           title: const Text('Error'),
      //           content: Text(current.error),
      //         );
      //       },
      //     );
      //   }
      // },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel vm) => Scaffold(
        appBar: buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: () {
            store.dispatch(NotificationReset());
            return store.dispatch(notificationGetMiddleware());
          },
          child: SafeArea(
            child: vm.notification_loader == false
                ? buildListViewSeparated(vm)
                : Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.storm_grey,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeparated(_ViewModel vm) {
    return Container(
      child: vm.listofdata.isNotEmpty
          ? ListView.separated(
              controller: scrollController,
              itemCount: vm.listofdata.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 14,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == vm.listofdata.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: vm.hasMore
                          ? CircularProgressIndicator(
                              color: MyTheme.storm_grey,
                            )
                          : const Text('No more data'),
                    ),
                  );
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: DeviceInfo(context).width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [CommonWidget.box_shadow()]),
                  // child0

                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 14, bottom: 14, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: MyImages.normalImage(
                                vm.listofdata[index].photo),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: DeviceInfo(context).width * 0.65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(vm.listofdata[index].time),
                                  vm.listofdata[index].readAt != "read"
                                      ? Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              color: MyTheme.failure,
                                              shape: BoxShape.circle),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: DeviceInfo(context).width * 0.66,
                              child: Text(
                                vm.listofdata[index].message,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(AppLocalizations.of(context).common_no_data),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).notifications_page_title,
        style: Styles.bold_app_accent_16,
      ),
      actions: [
        PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 20,
          ),
          onSelected: (value) {
            switch (value.toString().toLowerCase()) {
              case 'mark all as read':
                store.dispatch(notificationReadMiddleware());
                break;
            }
          },
          itemBuilder: (context) {
            return items
                .map((e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(color: Colors.black),
                    )))
                .toList();
          },
        )
      ],
    );
  }
}

class _ViewModel {
  var listofdata;
  var status;
  var error;
  var notification_loader;
  var hasMore;

  _ViewModel(
      {this.hasMore,
      this.listofdata,
      this.status,
      this.error,
      this.notification_loader});

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      listofdata: store.state.notificationState.notification_list,
      status: store.state.notificationState.notificationStatus,
      error: store.state.notificationState.error,
      notification_loader: store.state.notificationState.notification_loader,
      hasMore: store.state.notificationState.hasMore,
    );
  }
}
