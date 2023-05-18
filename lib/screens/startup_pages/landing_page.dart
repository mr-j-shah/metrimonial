import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_text_button.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/lading_page/landing.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/on_boarding_pages.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        body: SizedBox(
          height: DeviceInfo(context).height,
          child: Stack(
            children: [
              SizedBox(
                height: DeviceInfo(context).height * .70,
                child: state.exploreState.isFetching == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      )
                    : CarouselSlider.builder(
                        carouselController:
                            state.landingState.carouselController,
                        itemCount:
                            state.exploreState.exploreList.sliderImages.length,
                        itemBuilder: (context, index, realIndex) {
                          return state.exploreState.exploreList != null &&
                                  state.exploreState.exploreList.sliderImages
                                      .isNotEmpty
                              ? MyImages.normalImage(state.exploreState
                                  .exploreList.sliderImages[index].image)
                              : const Center(
                                  child: Text('No Data Found'),
                                );
                        },
                        options: CarouselOptions(
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            store
                                .dispatch(SetCarouselIndexAction(index: index));
                          },
                          // enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      ),
              ),
              // upper most container
              Positioned(
                bottom: 0,
                child: Container(
                  width: DeviceInfo(context).width,
                  decoration: BoxDecoration(
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSmoothIndicator(
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.white.withOpacity(0.8),
                                  activeDotColor: Colors.white,
                                  dotHeight: 8,
                                  dotWidth: 8),
                              activeIndex: state.landingState.carouselIndex,
                              count: state.exploreState.exploreList
                                      ?.sliderImages?.length ??
                                  0,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        Text(
                          AppLocalizations.of(context).landing_page_title,
                          // style: Styles.bold_white_30,
                          style: Styles.regularWhiteBold(context, 10),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context).landing_page_sub_title,
                          style: Styles.regular_white_14,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextButton(
                              horizontal: 18.0,
                              vertical: 10.0,
                              color: Colors.black.withOpacity(0.1),
                              onPressed: () {
                                prefs.setBool(Const.isViewed, true);
                                NavigatorPush.push(
                                  page: Main(),
                                );
                              },
                              text: Text(
                                AppLocalizations.of(context).common_get_started,
                                style: Styles.bold_white_14,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavigatorPush.push(
                                    page: const OnBoardingPages(),
                                  );
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                        .landing_page_how_it_works,
                                    style: Styles.italic_white_14))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
