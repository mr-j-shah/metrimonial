import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeScreen extends StatefulWidget {
  var amount;
  String payment_type;
  String payment_method_key;
  String package_id;

  StripeScreen(
      {Key key,
      this.amount,
      this.payment_type,
      this.payment_method_key,
      this.package_id})
      : super(key: key);

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  WebViewController _webViewController;
  String accessToken = prefs.getString("_accessToken");
  var userId = prefs.getInt("userId");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppBar(text: AppLocalizations.of(context).stripe_screen_title)
              .build(context),
      body: buildBody(),
    );
  }

  void getData() {
    _webViewController
        .evaluateJavascript("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      //print(data.toString());
      if (responseJSON["result"] == false) {
        MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);
        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        MyScaffoldMessenger().sf_messenger(text: responseJSON["message"]);

        if (widget.payment_type == "wallet_payment") {
          NavigatorPush.push_remove_untill(
            page: MyWallet(
              from_wallet: true,
            ),
          );
          OneContext().navigator.push(
                MaterialPageRoute(
                  builder: (context) => MyWallet(
                    from_wallet: true,
                  ),
                ),
              );
        } else if (widget.payment_type == "package_payment") {
          OneContext().navigator.push(
                MaterialPageRoute(
                  builder: (context) => PackageHistory(
                    from_package: true,
                  ),
                ),
              );
        }
      }
    });
  }

  Widget buildBody() {
    String initialUrl =
        "${AppConfig.BASE_URL}/stripe?amount=${widget.amount}&payment_method=${widget.payment_method_key}&payment_type=${widget.payment_type}&package_id=${widget.package_id}&user_Id=$userId";

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: initialUrl != null
            ? WebView(
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  _webViewController.loadUrl(initialUrl, headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer $accessToken"
                  });
                },
                onWebResourceError: (error) {},
                onPageFinished: (page) {
                  if (page.contains("/stripe/success")) {
                    getData();
                  } else if (page.contains("/stripe/cancel")) {
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
