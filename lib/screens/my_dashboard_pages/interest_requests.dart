import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/accept_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/interest_request_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterestRequest extends StatefulWidget {
  const InterestRequest({Key key}) : super(key: key);

  @override
  State<InterestRequest> createState() => _InterestRequestState();
}

class _InterestRequestState extends State<InterestRequest> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.dispatch(Reset.interestRequestList);
    store.dispatch(interestRequestMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.interestRequestState.hasMore) {
          store.dispatch(interestRequestMiddleware());
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
                    .interest_request_screen_appbar_title)
            .build(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.interestRequestState.isFetching
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.storm_grey,
                    ),
                  )
                : buildListViewSeperated(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeperated(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          store.dispatch(Reset.interestRequestList);
          store.dispatch(interestRequestMiddleware());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          child: state.interestRequestState.interestRequestList.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      state.interestRequestState.interestRequestList.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index ==
                        state.interestRequestState.interestRequestList.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: state.interestRequestState.hasMore
                              ? CircularProgressIndicator(
                                  color: MyTheme.storm_grey,
                                )
                              : const Text('No more data'),
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 3),

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
                          Container(
                            height: 145,
                            width: 84.0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0)),
                              child: MyImages.normalImage(state
                                  .interestRequestState
                                  .interestRequestList[index]
                                  .photo),
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
                                        state.interestRequestState
                                            .interestRequestList[index].name,
                                        style: Styles.bold_arsenic_14,
                                      ),
                                      state
                                                  .interestRequestState
                                                  .interestRequestList[index]
                                                  .status ==
                                              "Approved"
                                          ? Container(
                                              // width: 60,
                                              decoration: BoxDecoration(
                                                  color: state
                                                              .interestRequestState
                                                              .interestRequestList[
                                                                  index]
                                                              .status ==
                                                          "Approved"
                                                      ? MyTheme.medium_sea_green
                                                      : MyTheme.very_light_grey,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              4.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                  state
                                                      .interestRequestState
                                                      .interestRequestList[
                                                          index]
                                                      .status,
                                                  style: Styles.bold_white_10,
                                                ),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    state.interestRequestState
                                                        .index = index;

                                                    store.dispatch(
                                                        acceptInterestMiddleware(
                                                            ctx: maincontext,
                                                            userId: state
                                                                .interestRequestState
                                                                .interestRequestList[
                                                                    index]
                                                                .id));
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            201, 227, 202, 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    32.0))),
                                                    child: Center(
                                                      child: state.interestRequestState
                                                                  .acceptInterest &&
                                                              state.interestRequestState
                                                                      .index ==
                                                                  index
                                                          ? Container(
                                                              height: 15,
                                                              width: 15,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 1,
                                                              ))
                                                          : Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      169,
                                                                      57,
                                                                      1),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    store.dispatch(RemoveItem(
                                                        item: state
                                                            .interestRequestState
                                                            .interestRequestList[index],
                                                        context: maincontext));
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            255, 221, 218, 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    32.0))),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color: Color.fromRGBO(
                                                            255, 75, 62, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                                          "${state.interestRequestState.interestRequestList[index].age} years",
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state
                                              .interestRequestState
                                              .interestRequestList[index]
                                              .country,
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
                                          state
                                              .interestRequestState
                                              .interestRequestList[index]
                                              .religion,
                                          style: Styles.regular_arsenic_14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state
                                              .interestRequestState
                                              .interestRequestList[index]
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
              : Center(
                  child: Text(AppLocalizations.of(context).common_no_data),
                ),
        ),
      ),
    );
  }
}
