import 'package:active_matrimonial_flutter_app/models_response/explore_response.dart';

class ExploreStoreAction {
  ExploreResponse payload;

  ExploreStoreAction({this.payload});

  @override
  String toString() {
    return 'ExploreStoreAction{payload: $payload}';
  }
}

class ExploreFailureAction {
  String error;

  ExploreFailureAction({this.error});

  @override
  String toString() {
    return 'ExploreFailureAction{error: $error}';
  }
}

class SetExploreFirstBannerCarouselIndex {
  int payload;

  SetExploreFirstBannerCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreFirstBannerCarouselIndex{payload: $payload}';
  }
}

class SetExploreSecondBannerCarouselIndex {
  int payload;

  SetExploreSecondBannerCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreSecondBannerCarouselIndex{payload: $payload}';
  }
}

class SetExploreHappyStoriesCarouselIndex {
  int payload;

  SetExploreHappyStoriesCarouselIndex({this.payload});

  @override
  String toString() {
    return 'SetExploreHappyStoriesCarouselIndex{payload: $payload}';
  }
}
