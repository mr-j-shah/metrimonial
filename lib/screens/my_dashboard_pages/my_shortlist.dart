import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyShortlist extends StatefulWidget {
  const MyShortlist({Key key}) : super(key: key);

  @override
  State<MyShortlist> createState() => _MyShortlistState();
}

class _MyShortlistState extends State<MyShortlist> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(ResetExpressInterest());

    store.dispatch(ShortListReset());

    store.dispatch(shortlistMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.shortlistState.hasMore) {
          store.dispatch(shortlistMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBar(
                text: AppLocalizations.of(context)
                    .my_shortlist_screen_appbar_title)
            .build(context),
        body: Column(
          children: [
            state.shortlistState.isFetching == false
                ? buildListViewSeparated(context, state)
                : Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeparated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          store.dispatch(ShortListReset(payload: true));
          store.dispatch(shortlistMiddleware());
          return Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: state.shortlistState.shortlistData.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal,
                      vertical: Const.kPaddingVertical),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.shortlistState.shortlistData.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.shortlistState.shortlistData.length) {
                      return GestureDetector(
                        onTap: () {
                          NavigatorPush.push(
                              page: UserPublicProfile(
                            user: state.shortlistState.shortlistData[index],
                          ));
                        },
                        child: ShortlistCard(
                          state: state,
                          index: index,
                          maincontext: maincontext,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: state.shortlistState.hasMore
                              ? CircularProgressIndicator(
                                  color: MyTheme.storm_grey,
                                )
                              : const Text('No more data'),
                        ),
                      );
                    }
                  },
                )
              : state.shortlistState.fullReset
                  ? Container()
                  : Visibility(
                      child: Center(
                        child:
                            Text(AppLocalizations.of(context).common_no_data),
                      ),
                    ),
        ),
      ),
    );
  }
}

class ShortlistCard extends StatelessWidget {
  final AppState state;
  final dynamic index;
  final BuildContext maincontext;

  const ShortlistCard({Key key, this.state, this.index, this.maincontext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// box decoration

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()]),
      // child0

      child: Row(
        children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            SizedBox(
              height: 139,
              width: 86.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0)),
                child: MyImages.normalImage(
                    state.shortlistState.shortlistData[index].photo),
              ),
            ),

            // app accent color over image
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 31,
                  width: DeviceInfo(context).width,
                  decoration: BoxDecoration(
                    color: MyTheme.app_accent_color,
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(12.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// add to interest
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          state.shortlistState.index = index;

                          // state.shortlistState.shortlistResponse.data[index]
                          //         .expressInterest || state.myInterestState.expressInterestResponse.result
                          //     ? MyScaffoldMessenger().sf_messenger(
                          //     text: "Already Expressed Interest")
                          //     : store.dispatch(expressInterestMiddleware(
                          //         user: state.shortlistState.shortlistResponse
                          //             .data[index]));
                          //
                          if (state.shortlistState.shortlistData[index]
                                  .expressInterest ||
                              state.myInterestState.expressInterestResponse
                                  .result) {
                            MyScaffoldMessenger().sf_messenger(
                                text: "Already Expressed Interest");
                          } else {
                            if (state.accountState.profileData
                                    .remainingInterest ==
                                0) {
                              MyScaffoldMessenger().sf_messenger(
                                  text: "Please update you package");
                            } else {
                              store.dispatch(expressInterestMiddleware(
                                  user: state
                                      .shortlistState.shortlistData[index]));
                            }
                          }
                        },
                        icon: state.myInterestState.isLoading &&
                                state.shortlistState.index == index
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                            : state.shortlistState.shortlistData[index]
                                        .expressInterest ||
                                    state.myInterestState
                                        .expressInterestResponse.result
                                ? Image.asset(
                                    'assets/icon/icon_love.png',
                                    color: Colors.white.withOpacity(0.5),
                                  )
                                : Image.asset(
                                    'assets/icon/icon_love.png',
                                  ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      const SizedBox(
                        width: 16,
                      ),

                      /// remove from shortlist button
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          store.dispatch(RemoveShortlistAction(
                              context: maincontext,
                              data: state.shortlistState.shortlistData[index]));
                        },
                        icon: Image.asset('assets/icon/icon_ignore_cancel.png'),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      )
                    ],
                  )),
            ),

            // icons of the stack over image
          ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, top: 14.0, right: 10.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.shortlistState.shortlistData[index].name,
                    style: Styles.bold_arsenic_14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${state.shortlistState.shortlistData[index].age} years',
                        style: Styles.regular_arsenic_14,
                      )),
                      Expanded(
                          child: Text(
                        state.shortlistState.shortlistData[index].country,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: Styles.regular_arsenic_14,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${state.shortlistState.shortlistData[index].religion}',
                        style: Styles.regular_arsenic_14,
                      )),
                      Expanded(
                          child: Text(
                        '${state.shortlistState.shortlistData[index].mothereTongue}',
                        style: Styles.regular_arsenic_14,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
