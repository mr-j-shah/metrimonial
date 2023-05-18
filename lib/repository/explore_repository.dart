import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/explore_response.dart';
import 'package:http/http.dart' as http;

class ExploreRepository {
  Future<ExploreResponse> fetchExplore() async {
    var baseUrl = "${AppConfig.BASE_URL}/home";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = exploreResponseFromJson(response.body);
    return data;
  }
}
