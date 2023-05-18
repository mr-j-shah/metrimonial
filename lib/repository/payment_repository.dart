import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/payments/payment_types_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  var accessToken = prefs.getString(Const.accessToken);
// payment types
  Future<PaymentTypesResponse> fetchPaymentTypes() async {
    var baseUrl = "${AppConfig.BASE_URL}/payment-types";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = paymentTypesResponseFromJson(response.body);
    return data;
  }

  // paypal post method
  Future getPaypalUrlResponse({
    String amount,
    String payment_method,
    String payment_type,
    var userId,
    var package_id,
  }) async {
    var post_body = jsonEncode({
      "payment_type": payment_type,
      "amount": amount,
      "payment_method": payment_method,
      "user_id": userId,
      "package_id": package_id
    });

    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/paypal/payment/pay?payment_method=${payment_method}&amount=${amount}&payment_type=${payment_type}&user_id=${userId}&package_id=${package_id}");

    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: post_body);

    return jsonDecode(response.body);
  }
}
