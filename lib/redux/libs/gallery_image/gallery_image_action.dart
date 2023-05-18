import 'package:active_matrimonial_flutter_app/models_response/gallery_images_response.dart';

class ImageLoader {}

class GalleryImageStoreAction {
  GalleryImagesResponse payload;

  GalleryImageStoreAction({this.payload});

  @override
  String toString() {
    return 'GalleryImageStoreAction{payload: $payload}';
  }
}

class GalleryImageFailureAction {
  String error;

  GalleryImageFailureAction({this.error});

  @override
  String toString() {
    return 'GalleryImageFailureAction{error: $error}';
  }
}
