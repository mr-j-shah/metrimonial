import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/my_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'interest_requests.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({Key key}) : super(key: key);

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(Reset.myInterestList);
    store.dispatch(myInterestMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.myInterestState.hasMore) {
          store.dispatch(myInterestMiddleware());
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
                    .my_interest_screen_appbar_title)
            .build(context),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => NavigatorPush.push(page: InterestRequest()),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: Const.kPaddingHorizontal),
                height: 45,
                width: DeviceInfo(context).width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: const Alignment(0.8, 1),
                    colors: [
                      MyTheme.gradient_color_1,
                      MyTheme.gradient_color_2,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)
                      .my_interest_screen_request_interests,
                  style: Styles.bold_white_14,
                )),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            state.myInterestState.isFetching
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
                  )
                : buildListViewSeperated(context, state)
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeperated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          store.dispatch(Reset.myInterestList);
          store.dispatch(myInterestMiddleware());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: state.myInterestState.myInterestList.isNotEmpty
              ? ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.myInterestState.myInterestList.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.myInterestState.myInterestList.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: state.myInterestState.hasMore
                              ? CircularProgressIndicator(
                                  color: MyTheme.storm_grey,
                                )
                              : const Text('No more data'),
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 3),
                      height: 139,

                      /// box decoration
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        boxShadow: [CommonWidget.box_shadow()],
                      ),
                      // child0

                      child: Row(
                        children: [
                          Container(
                            height: DeviceInfo(context).height,
                            width: 84.0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0)),
                              child: MyImages.normalImage(state
                                  .myInterestState.myInterestList[index].photo),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0,
                                  top: 16.0,
                                  right: 10.0,
                                  bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.myInterestState
                                            .myInterestList[index].name,
                                        style: Styles.bold_arsenic_14,
                                      ),
                                      Container(
                                        // width: 60,
                                        decoration: BoxDecoration(
                                            color: state
                                                        .myInterestState
                                                        .myInterestList[index]
                                                        .status ==
                                                    "Approved"
                                                ? MyTheme.medium_sea_green
                                                : MyTheme.very_light_grey,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Text(
                                            state.myInterestState
                                                .myInterestList[index].status,
                                            style: Styles.bold_white_10,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${state.myInterestState.myInterestList[index].age} years",
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.myInterestState
                                              .myInterestList[index].country,
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.myInterestState
                                              .myInterestList[index].religion,
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state
                                              .myInterestState
                                              .myInterestList[index]
                                              .mothereTongue,
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              : state.myInterestState.fullReset
                  ? Container()
                  : Container(
                      height: DeviceInfo(context).height,
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
