import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_state.dart';

ExploreState explore_reducer(ExploreState state, action) {
  if (action is ExploreStoreAction) {
    state.isFetching = false;
    state.exploreList = action.payload.data;

    return state;
  }
  if (action is ExploreFailureAction) {
    state.error = action.error;
    return state;
  }
  if (action == Reset.exploreList) {
    state = ExploreState.initialState();
    return state;
  }

  // carousel first index set
  if (action is SetExploreFirstBannerCarouselIndex) {
    state.carouselIndex = action.payload;
    return state;
  }

  // carousel second index set
  if (action is SetExploreSecondBannerCarouselIndex) {
    state.carouselIndex2 = action.payload;
    return state;
  }
  // set happy stories carousel set
  if (action is SetExploreHappyStoriesCarouselIndex) {
    state.happyStoriesIndex = action.payload;
    return state;
  }

  return state;
}
