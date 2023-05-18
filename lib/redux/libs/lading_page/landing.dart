import 'package:carousel_slider/carousel_slider.dart';

class LandingState {
  final CarouselController carouselController = CarouselController();
  var carouselIndex = 0;

  LandingState({
    this.carouselIndex,
  });

  LandingState.initialState() : carouselIndex = 0;
}

LandingState landingReducer(LandingState state, dynamic action) {
  if (action is SetCarouselIndexAction) {
    state.carouselIndex = action.index;
    return state;
  }

  return state;
}

class SetCarouselIndexAction {
  int index;

  SetCarouselIndexAction({this.index});

  @override
  String toString() {
    return 'SetCarouselIndexAction{index: $index}';
  }
}
