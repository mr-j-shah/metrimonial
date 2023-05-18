import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_details_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/chat/chat_reply_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final dynamic chatId;
  final dynamic chatData;
  final dynamic name;
  final dynamic picture;

  Chat({this.chatId, this.chatData, Key key, this.name, this.picture})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final my_text_controller = TextEditingController();
  String value;
  var myId = prefs.getInt('userId');

  fetchAll() {
    store.dispatch(Reset.chatDetailsList);
    store.dispatch(chatDetailsMiddleware(userId: widget.chatId));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAll();
  }

  @override
  void dispose() {
    my_text_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context, state),
        body: state.chatDetailsState.isFetching
            ? Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal, vertical: 10.0),
                child: Stack(
                  children: [
                    state.chatDetailsState.chatDetailsList==[]?
                        Center(child: Text('No Messages!'),):
                    ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: state
                          .chatDetailsState.chatDetailsList.messages.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        /// storing data in chat details
                        ///  only for chat details
                        var chatDetails = state
                            .chatDetailsState.chatDetailsList.messages[index];

                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment:
                                  chatDetails.senderUserId == myId
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                if (chatDetails.senderUserId != myId)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          MyImages.normalImage(widget.picture),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  // width: 240,
                                  constraints: BoxConstraints(
                                    maxWidth: DeviceInfo(context).width / 1.5,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: chatDetails.senderUserId != myId
                                        ? MyTheme.solitude
                                        : MyTheme.app_accent_color,
                                    borderRadius: chatDetails.senderUserId ==
                                            myId
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                            bottomLeft: Radius.circular(12.0),
                                            bottomRight: Radius.circular(6.0))
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                            bottomLeft: Radius.circular(6.0),
                                            bottomRight: Radius.circular(12.0)),
                                  ),
                                  // height: 50,

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 6,
                                        top: 15,
                                        bottom: 15),
                                    child: Text(
                                      chatDetails.message ?? '',
                                      style: TextStyle(
                                          color:
                                              chatDetails.senderUserId != myId
                                                  ? MyTheme.arsenic
                                                  : Colors.white),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                if (chatDetails.senderUserId == myId)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: MyImages.normalImage(state
                                          .chatDetailsState.chatDetailsList
                                          .authUserPhoto),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    buildBottomMessageSection(context)
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildBottomMessageSection(BuildContext context) {
    return Positioned(
        bottom: 5,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: DeviceInfo(context).width - 100,
              decoration: BoxDecoration(
                  color: MyTheme.zircon,
                  borderRadius: BorderRadius.all(Radius.circular(35.0))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: my_text_controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your message here...',
                    hintStyle: TextStyle(
                      color: MyTheme.storm_grey,
                    ),
                  ),
                ),
              ),
            ),

            /// send button
            InkWell(
              onTap: () {
                store.dispatch(chatReplyMiddleware(
                    id: widget.chatId,
                    text: my_text_controller.text,
                    attachment: null));
                my_text_controller.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: CircleAvatar(
                backgroundColor: MyTheme.app_accent_color,
                child: Center(
                  child: Image.asset(
                    'assets/icon/icon_send.png',
                    height: 25,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildAppBarContainer(
    BuildContext context,
    AppState state,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: Const.kPaddingHorizontal, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  height: 50,
                  width: 50,
                  child: MyImages.normalImage(widget.picture),
                )
                ,
              ),

              SizedBox(
                width: 10,
              ),
              Text(widget.name, style: Styles.bold_arsenic_16),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, AppState state) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: buildAppBarContainer(context, state),
    );
  }
}
