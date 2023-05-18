import 'package:active_matrimonial_flutter_app/models_response/explore_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExploreState {
  bool isFetching;
  ExploreData exploreList;
  String error;
  int carouselIndex;
  int carouselIndex2;
  int happyStoriesIndex;
  CarouselController carouselController = CarouselController();
  CarouselController carouselController2 = CarouselController();
  CarouselController happyStoriesController = CarouselController();
  CarouselController reviewController = CarouselController();
  PageController pageController = PageController();

  ExploreState({
    this.happyStoriesIndex,
    this.isFetching,
    this.exploreList,
    this.error,
    this.carouselIndex,
    this.carouselIndex2,
  });

  ExploreState.initialState()
      : isFetching = true,
        exploreList = null,
        carouselIndex = 0,
        carouselIndex2 = 0,
        happyStoriesIndex = 0,
        error = '';
}
