import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_history_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/referral/referral_withdraw_request_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_balance_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralEarningsWallet extends StatefulWidget {
  const ReferralEarningsWallet({Key key}) : super(key: key);

  @override
  State<ReferralEarningsWallet> createState() => _ReferralEarningsWalletState();
}

class _ReferralEarningsWalletState extends State<ReferralEarningsWallet> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _details = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(Reset.referralHistoryRequestList);
    store.dispatch(walletBalanceMiddleware());
    store.dispatch(referralWithdrawRequestHistoryMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.referralWithdrawRequestHistoryState.hasMore) {
          store.dispatch(walletBalanceMiddleware());
          store.dispatch(referralWithdrawRequestHistoryMiddleware());
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
                text: AppLocalizations.of(context).referral_earnings_wallet)
            .build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    buildWalletBalance(state),
                    const SizedBox(
                      width: 14,
                    ),
                    buildWalletRecharge(context),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state.referralWithdrawRequestHistoryState.isFetching
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      )
                    : buildListViewSeperated(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeperated(AppState state) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: state.referralWithdrawRequestHistoryState
                .referralWithdrawRequestHistoryList.isNotEmpty
            ? ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.referralWithdrawRequestHistoryState
                        .referralWithdrawRequestHistoryList.length +
                    1,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 14,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index ==
                      state.referralWithdrawRequestHistoryState
                          .referralWithdrawRequestHistoryList.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: state.referralWithdrawRequestHistoryState.hasMore
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
                              name: AppLocalizations.of(context)
                                  .wallet_screen_date,
                              data: state
                                  .referralWithdrawRequestHistoryState
                                  .referralWithdrawRequestHistoryList[index]
                                  .date),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)
                                  .wallet_screen_amount,
                              data: state
                                  .referralWithdrawRequestHistoryState
                                  .referralWithdrawRequestHistoryList[index]
                                  .amount),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)
                                  .wallet_screen_details,
                              data: state
                                  .referralWithdrawRequestHistoryState
                                  .referralWithdrawRequestHistoryList[index]
                                  .details),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                AppLocalizations.of(context)
                                    .wallet_screen_status,
                                style: Styles.regular_arsenic_12,
                              )),
                              Expanded(
                                child: Text(
                                  state
                                      .referralWithdrawRequestHistoryState
                                      .referralWithdrawRequestHistoryList[index]
                                      .status,
                                  style: state
                                              .referralWithdrawRequestHistoryState
                                              .referralWithdrawRequestHistoryList[
                                                  index]
                                              .status !=
                                          'Approved'
                                      ? Styles.bold_arsenic_12
                                      : Styles.bold_green_12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Data Found'),
              ),
      ),
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

  Expanded buildWalletBalance(AppState state) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: MyTheme.app_accent_color,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 11),
          child: Column(
            children: [
              Image.asset(
                'assets/icon/icon_my_wallet.png',
                height: 16,
              ),
              const SizedBox(
                height: 11,
              ),
              Text(
                state.myWalletState.balance,
                style: Styles.bold_white_14,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                AppLocalizations.of(context).wallet_screen_my_wallet,
                style: const TextStyle(
                    color: Color.fromRGBO(
                      225,
                      227,
                      230,
                      1,
                    ),
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildWalletRecharge(maincontext) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _dialogBuilder(context, maincontext),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            color: MyTheme.zircon,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/icon_plus.png',
                    height: 16,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(AppLocalizations.of(context).referral_earnings_wallet,
                      style: Styles.regular_arsenic_12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, maincontext) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recharge wallet',
            style: Styles.bold_arsenic_14,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Amount*',
                    style: Styles.regular_arsenic_14,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        filled: true,
                        fillColor: MyTheme.solitude,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: MyTheme.app_accent_color)),

                        isDense: true,
                        hintStyle: Styles.regular_gull_grey_12,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),

                        // helperText: 'Helper text',
                      ),
                      controller: _amount,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Details*',
                    style: Styles.regular_arsenic_14,
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Enter Details",
                          filled: true,
                          fillColor: MyTheme.solitude,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: MyTheme.app_accent_color)),

                          hintStyle: Styles.regular_gull_grey_12,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),

                          // helperText: 'Helper text',
                        ),
                        controller: _details,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyTheme.white,
                padding: EdgeInsets.all(16.0),
                textStyle: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                store.dispatch(referralWithdrawRequestMiddleware(
                    amount: _amount.text, details: _details.text));
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context).common_confirm),
            ),
          ],
        );
      },
    );
  }
}
