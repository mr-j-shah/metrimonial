import 'dart:convert';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/package/package_middlewares.dart';
import 'package:active_matrimonial_flutter_app/repository/payment_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalScreen extends StatefulWidget {
  String amount;
  String payment_type;
  String payment_method_key;
  String package_id;

  PaypalScreen(
      {Key key,
      this.amount,
      this.payment_type,
      this.payment_method_key,
      this.package_id})
      : super(key: key);

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  WebViewController _webViewController;
  dynamic _initial_url;
  var accessToken = prefs.getString(Const.accessToken);
  var userId = prefs.getInt("userId");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetInitialUrl();
  }

  getSetInitialUrl() async {
    // print("-------get initial url-------------");
    // print(widget.amount);
    // print(widget.payment_type);
    // print(widget.payment_method_key);
    // print(widget.package_id);

    Map paypalUrlResponse = await PaymentRepository().getPaypalUrlResponse(
        amount: widget.amount.toString(),
        payment_method: widget.payment_method_key,
        payment_type: widget.payment_type,
        package_id: widget.package_id,
        userId: userId);

    if (paypalUrlResponse.keys.toList()[0] == false) {
      MyScaffoldMessenger()
          .sf_messenger(text: paypalUrlResponse.keys.toList()[2]);
      Navigator.of(context).pop();
      return;
    }
    paypalUrlResponse.values.toList();

    _initial_url = paypalUrlResponse.values.toList()[1];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppBar(text: AppLocalizations.of(context).paypal_screen_title)
              .build(context),
      body: buildBody(),
    );
  }

  void getData() {
    _webViewController.evaluateJavascript("document.body.innerText").then(
      (data) {
        var decodedJSON = jsonDecode(data);
        Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
        if (responseJSON["result"] == false) {
          MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);
          Navigator.pop(context);
        } else if (responseJSON["result"] == true) {
          MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);
          if (widget.payment_type == "wallet_payment") {
            OneContext().navigator.push(
                  MaterialPageRoute(
                    builder: (context) => MyWallet(
                      from_wallet: true,
                    ),
                  ),
                );
          }
          if (widget.payment_type == "package_payment") {
            store.dispatch(packageDetailsMiddleware());

            OneContext().navigator.push(
                  MaterialPageRoute(
                    builder: (context) => PackageHistory(
                      from_package: true,
                    ),
                  ),
                );
          }
        }
      },
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _initial_url != null
            ? WebView(
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  _webViewController.loadUrl(_initial_url, headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer $accessToken"
                  });
                },
                onWebResourceError: (error) {},
                onPageFinished: (page) {
                  if (page.contains("/paypal/payment/done")) {
                    getData();
                  } else if (page.contains("/paypal/payment/cancel")) {
                    Navigator.of(context).pop();
                    return;
                  }
                },
              )
            : const Center(child: Text("loading...")),
      ),
    );
  }
}
