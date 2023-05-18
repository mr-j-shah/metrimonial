import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_action.dart';
import 'package:active_matrimonial_flutter_app/repository/gallery_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> galleryImageMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await GalleryRepository().fetchGalleryImage();
      store.dispatch(GalleryImageStoreAction(payload: data));
    } catch (e) {
      debugPrint(e.toString());
      store.dispatch(GalleryImageFailureAction(error: e.toString()));
      return;
    }
  };
}
