import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/payment_types/payment_types_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/paypal_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/stripe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Payment extends StatefulWidget {
  double amount;
  @required
  String payment_type;

  // String payment_method_key;
  var package_id;
  String title;

  Payment(
      {Key key,
      this.amount = 0.00,
      this.title = "",
      this.payment_type = "",
      // this.payment_method_key = "",
      this.package_id = "0"})
      : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController _amount_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var textfieldheight = false;

  onPaymentMethodItemTap(index) {
    if (store.state.paymentTypesState.selected_payment_method !=
        store.state.paymentTypesState.paymentTypes[index].paymentType) {
      store.dispatch(
        UpdatePaymentMethodKeyAction(
            index: store.state.paymentTypesState.paymentTypes[index],
            // method: store.state.checkoutState.paymentTypesResponse.data[index]
            //     .paymentType,
            method: widget.payment_type,
            key: store
                .state.paymentTypesState.paymentTypes[index].paymentTypeKey),
      );
    }
  }

  onPressPlaceOrderOrProceed(AppState state, {var package_id}) {
    if (store.state.paymentTypesState.selected_payment_method_key == "paypal") {
      NavigatorPush.push(
          page: PaypalScreen(
        amount: widget.payment_type == "wallet_payment"
            ? _amount_controller.text
            : widget.amount.toString(),
        payment_type: widget.payment_type,
        payment_method_key: state.paymentTypesState.selected_payment_method_key,
        package_id: package_id.toString(),
      ));

      // NavigatorPush.pushandremoveuntill(page: PaypalScreen(
      //   amount: widget.payment_type == "wallet_payment"
      //       ? _amount_controller.text
      //       : widget.amount.toString(),
      //   payment_type: widget.payment_type,
      //   payment_method_key: state.checkoutState.selected_payment_method_key,
      //   package_id: package_id.toString(),
      // ));

    }
    if (store.state.paymentTypesState.selected_payment_method_key == "stripe") {
      NavigatorPush.push(
          page: StripeScreen(
        amount: widget.payment_type == "wallet_payment"
            ? _amount_controller.text
            : widget.amount,
        payment_type: widget.payment_type,
        payment_method_key: state.paymentTypesState.selected_payment_method_key,
        package_id: package_id.toString(),
      ));

      // NavigatorPush.pushandremoveuntill(page: StripeScreen(
      //   amount: widget.payment_type == "wallet_payment"
      //       ? _amount_controller.text
      //       : widget.amount,
      //   payment_type: widget.payment_type,
      //   payment_method_key:
      //   state.checkoutState.selected_payment_method_key,
      //   package_id: package_id.toString(),
      // ));

    }
    // if (store.state.checkoutState.selected_payment_method_key == "instamojo") {
    //   NavigatorPush.push(
    //     context: context,
    //     page: StripeScreen(
    //         amount: widget.payment_type == "wallet_payment"?_amount_controller.text: widget.amount,
    //         payment_type: state.checkoutState.selected_payment_method,
    //         payment_method_key:
    //             state.checkoutState.selected_payment_method_key),
    //   );
    // }
  }

  @override
  void dispose() {
    _amount_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.paymentTypes),
        store.dispatch(paymentTypesMiddleware()),
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            store.dispatch(
              AddPaymentMethodKeyAction(
                  method: widget.payment_type,
                  key: store
                      .state.paymentTypesState.paymentTypes[0].paymentTypeKey),
            );
          },
        )
      ],
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context, state),
        bottomNavigationBar: buildBottomAppBar(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return state.paymentTypesState.isFetching
        ? Center(
            child: CircularProgressIndicator(
              color: MyTheme.storm_grey,
            ),
          )
        : Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.payment_type == "wallet_payment"
                        ? state.paymentTypesState.paymentTypes.length - 1
                        : state.paymentTypesState.paymentTypes.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          onPaymentMethodItemTap(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 3),
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                height: 100,
                                decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [CommonWidget.box_shadow()]),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.network(
                                          state.paymentTypesState
                                              .paymentTypes[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 30.0),
                                            child: Text(
                                              state.paymentTypesState
                                                  .paymentTypes[index].title,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Styles.medium_gull_grey_14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 16,
                                top: 16,
                                child: buildPaymentMethodCheckContainer(state
                                        .paymentTypesState
                                        .selected_payment_method_key ==
                                    state.paymentTypesState.paymentTypes[index]
                                        .paymentTypeKey),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              widget.payment_type == "wallet_payment"
                  ? buildAmount()
                  : Container()
            ],
          );
  }

  BottomAppBar buildBottomAppBar(BuildContext context, AppState state) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TextButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (widget.payment_type == 'wallet_payment') {
                    if (!_formKey.currentState.validate()) {
                      MyScaffoldMessenger()
                          .sf_messenger(text: "Form's not validated!");
                    } else {
                      onPressPlaceOrderOrProceed(
                        state,
                      );
                      _amount_controller.clear();
                    }
                  } else {
                    onPressPlaceOrderOrProceed(state,
                        package_id: widget.package_id);
                    // _amount_controller.clear();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.app_accent_color),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: MyTheme.app_accent_color)),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).common_confirm,
                  style: Styles.medium_white_16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodCheckContainer(bool check) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: check ? 1 : 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.green),
        child: const Padding(
          padding: EdgeInsets.all(3),
          child: Icon(Icons.check, color: Colors.white, size: 10),
        ),
      ),
    );
  }

  Widget buildAmount() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: textfieldheight == true ? 75 : 51,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    setState(() {
                      textfieldheight = true;
                    });
                    return "Required Field";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _amount_controller,
                decoration:
                    InputStyle.inputDecoration_text_field(hint: "Amount"),
              ),
            ],
          ),
        ),
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
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        widget.title,
        style: Styles.bold_app_accent_16,
      ),
    );
  }
}
