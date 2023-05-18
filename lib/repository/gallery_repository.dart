import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/gallery_images_response.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:http/http.dart' as http;

class GalleryRepository {
  Future<GalleryImagesResponse> fetchGalleryImage() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image";
    var accessToken = prefs.getString(Const.accessToken);
    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = galleryImagesResponseFromJson(response.body);
    return data;
  }
}
