import 'dart:async';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/custom/my_smooth_indicator.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatList extends StatefulWidget {
  bool backButtonAppearance;

  ChatList({Key key, this.backButtonAppearance}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  PageController matched_profile_controller = PageController();

  Timer timer;

  @override
  void initState() {
    super.initState();
    store.dispatch(Reset.chatList);
    store.dispatch(chatMiddleware());
    timer = Timer.periodic(
        Duration(seconds: 20), (Timer t) => store.dispatch(chatMiddleware()));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: state.chatState.isFetching == false
              ? RefreshIndicator(
                  onRefresh: () async {
                    store.dispatch(chatMiddleware());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildMatchProfileContainer(context, state),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Const.kPaddingHorizontal,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context).chat_list_messages,
                              style: Styles.bold_app_accent_16,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),

                      /// messages container
                      buildListViewMessagesContainer(context, state)
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.backButtonAppearance,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/icon/icon_pop.png',
                            height: 20,
                            width: 20,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context).profile_screen_messages,
                  style: Styles.bold_app_accent_16,
                ),
              ],
            ),
            CommonWidget.social_button(
                onpressed: () {
                  NavigatorPush.push(page: Notifications());
                },
                icon: "icon_bell.png",
                gradient: Styles.buildLinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ],
        ),
      ),
    );
  }

  Widget buildMatchProfileContainer(BuildContext context, AppState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Const.kPaddingHorizontal,
          vertical: Const.kPaddingVertical),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              MyTheme.gradient_color_1,
              MyTheme.gradient_color_2,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, bottom: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).chat_list_matched_profile,
                style: Styles.bold_white_12,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 72,
                child: state.chatState.matchedProfile.matchedProfiles.isNotEmpty
                    ? PageView.builder(
                        controller: matched_profile_controller,
                        itemCount: state.chatState.matchedProfile.matchedProfiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              NavigatorPush.push(
                                  page: UserPublicProfile(
                                user: state.chatState.matchedProfile.matchedProfiles[index],
                              ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 72,
                                  width: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(state.chatState
                                          .matchedProfile.matchedProfiles[index].photo),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.chatState.matchedProfile.matchedProfiles[index]
                                            .name,
                                        style: Styles.bold_white_14,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.chatState.matchedProfile.matchedProfiles[index].age} yrs, ${state.chatState.matchedProfile.matchedProfiles[index].height} feet 4 inch, ${state.chatState.matchedProfile.matchedProfiles[index].maritalStatus},',
                                            style: Styles.regular_white_12,
                                          ),
                                          Text(
                                            '${state.chatState.matchedProfile.matchedProfiles[index].religion}, ${state.chatState.matchedProfile.matchedProfiles[index].caste}',
                                            style: Styles.regular_white_12,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        AppLocalizations.of(context).common_no_data,
                        style: TextStyle(color: Colors.white),
                      )),
              ),
              Align(
                alignment: Alignment.center,
                child: MySmoothIndicator.worm_effect(
                    controller: matched_profile_controller,
                    length: state.chatState.matchedProfile.matchedProfiles.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListViewMessagesContainer(BuildContext context, AppState state) {
    return Expanded(
      child: Container(
        height: DeviceInfo(context).height,
        child: state.chatState.chatList.isNotEmpty
            ? ListView.separated(
                itemCount: state.chatState.chatList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat(
                                chatId: state.chatState.chatList[index].id,
                                chatData: state.chatState.chatList[index],
                                name:
                                    state.chatState.chatList[index].memberName,
                                picture: state
                                    .chatState.chatList[index].memberPhoto)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Const.kPaddingHorizontal,
                      ),
                      height: 70,
                      decoration: BoxDecoration(
                        color: MyTheme.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        boxShadow: [CommonWidget.box_shadow()],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 14.0,
                            top: Const.kPaddingVertical,
                            bottom: Const.kPaddingVertical,
                            right: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: MyImages.normalImage(state
                                            .chatState
                                            .chatList[index]
                                            .memberPhoto),
                                      ),
                                    ),
                                    Positioned(
                                      right: 6,
                                      left: 25,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: state
                                                        .chatState
                                                        .chatList[index]
                                                        .active ==
                                                    0
                                                ? Colors.red[400]
                                                : Colors.green[400]),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// name and message
                                    Row(
                                      children: [
                                        Text(
                                          state.chatState.chatList[index]
                                              .memberName,
                                          style: Styles.bold_arsenic_16,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 24,
                                          child: Image.network(state
                                              .chatState
                                              .chatList[index]
                                              .memberPackage
                                              .image),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                          state.chatState.chatList[index]
                                              .lastMessage,
                                          maxLines: 1,
                                          style: Styles.regular_gull_grey_12,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            state.chatState.chatList[index]
                                        .unseenMessageCount ==
                                    0
                                ? const Text('')
                                : Container(
                                    height: 20,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                        color: MyTheme.zircon),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 3),
                                      child: Text(
                                        state.chatState.chatList[index]
                                            .unseenMessageCount
                                            .toString(),
                                        style: TextStyle(
                                            color: MyTheme.app_accent_color),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(AppLocalizations.of(context).common_no_data),
              ),
      ),
    );
  }
}
