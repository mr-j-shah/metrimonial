import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_state.dart';

GalleryImageState gallery_image_reducer(GalleryImageState state, action) {
  if (action is GalleryImageStoreAction) {
    state.isFetching = false;
    state.galleryImageList = action.payload.data;
    return state;
  }
  if (action is GalleryImageFailureAction) {
    state.error = action.error;
    return state;
  }

  if (action is ImageLoader) {
    state.isLoading = !state.isLoading;
    return state;
  }

  if (action == Reset.myGallery) {
    state = GalleryImageState.initialState();
    return state;
  }

  return state;
}
