import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_balance_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/wallet/wallet_history_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWallet extends StatefulWidget {
  bool from_wallet;

  MyWallet({this.from_wallet = false, Key key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(Reset.myWallet);
    store.dispatch(walletHistoryMiddleware());
    store.dispatch(walletBalanceMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.myWalletState.hasMore) {
          store.dispatch(walletHistoryMiddleware());
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
      builder: (_, state) => WillPopScope(
        onWillPop: () {
          if (widget.from_wallet) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const Account();
            }), (route) => false);
            return Future<bool>.value(false);
          } else {
            return Future<bool>.value(true);
          }
        },
        child: Scaffold(
          appBar: CommonAppBar(text: AppLocalizations.of(context).wallet_screen)
              .build(context),
          body: RefreshIndicator(
            onRefresh: () => store.dispatch(walletHistoryMiddleware()),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Const.kPaddingHorizontal, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// appbar
                    Row(
                      children: [
                        buildWalletBalance(state),
                        const SizedBox(
                          width: 14,
                        ),
                        buildWalletRecharge(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    state.myWalletState.isFetching
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              ),
                            ),
                          )
                        : buildListViewSeperated(state),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListViewSeperated(AppState state) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        child: state.myWalletState.balanceHistory.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.myWalletState.balanceHistory.length + 1,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 14,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.myWalletState.balanceHistory.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: state.myWalletState.hasMore
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
                                  .myWalletState.balanceHistory[index].date),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)
                                  .wallet_screen_amount,
                              data: state
                                  .myWalletState.balanceHistory[index].amount),
                          const SizedBox(
                            height: 5,
                          ),
                          buildNameDateRow(
                              name: AppLocalizations.of(context)
                                  .wallet_screen_details,
                              data: state.myWalletState.balanceHistory[index]
                                  .paymentMethod),
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
                                  state.myWalletState.balanceHistory[index]
                                      .approval,
                                  style: state.myWalletState
                                              .balanceHistory[index].approval !=
                                          'Approved'
                                      ? Styles.bold_gull_grey_12
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
                child: Text('No History Found'),
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
          ),
        )
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
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Column(
            children: [
              Image.asset(
                'assets/icon/icon_my_wallet.png',
                height: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.myWalletState.balance,
                style: Styles.bold_white_16,
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

  Widget buildWalletRecharge() {
    return Expanded(
      child: GestureDetector(
        onTap: () => NavigatorPush.push(
          page: Payment(
            payment_type: "wallet_payment",
            title: "Wallet Recharge",
          ),
        ),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            color: MyTheme.zircon,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/icon_plus.png',
                    height: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .wallet_screen_recharge_wallet,
                      style: Styles.regular_arsenic_12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
