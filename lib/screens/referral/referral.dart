import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_code_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_users_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';

class Referral extends StatefulWidget {
  const Referral({Key key}) : super(key: key);

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(Reset.referralUserList);
    store.dispatch(referralCodeMiddleware());
    store.dispatch(referralUsersMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.referralState.hasMore) {
          store.dispatch(referralCodeMiddleware());
          store.dispatch(referralUsersMiddleware());
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
      builder: (_, state) =>
          Scaffold(
            appBar: CommonAppBar(text: AppLocalizations
                .of(context)
                .referral_screen)
                .build(context),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations
                                .of(context)
                                .referral_screen_referral_code,
                            style: Styles.regular_arsenic_14,
                          ),
                          Text(
                            ' ${state.referralState.referralCode}',
                            style: Styles.bold_arsenic_14,
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: state.referralState
                              .referralCode))
                              .then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Copied to clipboard"),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(milliseconds: 300),
                            ));
                          });
                        },
                        icon: Image.asset(
                          'assets/icon/icon_copy.png',
                          height: 22,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state.referralState.isFetching
                      ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    ),
                  )
                      : buildListViewSeparated(context, state),
                ],
              ),
            ),
          ),
    );
  }

  Widget buildListViewSeparated(BuildContext context, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          store.dispatch(Reset.referralUserList);
          store.dispatch(referralCodeMiddleware());
          store.dispatch(referralUsersMiddleware());
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: state.referralState.referralUserList.isNotEmpty
              ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.referralState.referralUserList.length + 1,
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(
              height: 14,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == state.referralState.referralUserList.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: state.referralState.hasMore
                        ? CircularProgressIndicator(
                      color: MyTheme.storm_grey,
                    )
                        : const Text('No more data'),
                  ),
                );
              }
              return Container(

                /// box decoration
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    boxShadow: [CommonWidget.box_shadow()]),
                // child0

                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, top: 14, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildNameDateRow(
                          name: AppLocalizations
                              .of(context)
                              .referral_screen_name,
                          data: state
                              .referralState.referralUserList[index].name),
                      const SizedBox(
                        height: 5,
                      ),
                      buildNameDateRow(
                          name: AppLocalizations
                              .of(context)
                              .referral_screen_date,
                          data: state
                              .referralState.referralUserList[index].date),
                    ],
                  ),
                ),
              );
            },
          ) : Center(
            child: Text('No Data Found.'),
          ),
        ),
      )
      ,
    );
  }

  Row buildNameDateRow({var name, var data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
              name,
              style: Styles.regular_arsenic_12,
            )),
        Expanded(
            child: Text(
              data,
              style: Styles.bold_arsenic_12,
            ))
      ],
    );
  }
}
