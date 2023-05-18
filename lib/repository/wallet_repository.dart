import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_balance_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/wallet/wallet_history_res.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class WalletRepository {
  Future<WalletBalanceResponse> fetchWalletBalance() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/my-wallet-balance";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = walletBalanceResponseFromJson(response.body);

    return data;
  }

  Future<WalletHistoryResponse> fetchWalletHistory({page}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/wallet?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = walletHistoryResponseFromJson(response.body);
    return data;
  }
}
