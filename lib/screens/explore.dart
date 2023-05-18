import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_animated_smooth_indicator.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/custom/shades.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_action.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blog_details.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blogs.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories_details.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/search.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../custom/custom_popup.dart';

class Explore extends StatefulWidget {
  const Explore({Key key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  var _color = MyTheme.silver;
  var _solitude = MyTheme.solitude;
  var _arsenic = MyTheme.arsenic;

  bool isLogin = prefs.getBool("isLogin") ?? false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExploreViewModel>(
      converter: (store) => ExploreViewModel.fromStore(store),
      builder: (_, ExploreViewModel vm) {
        return Scaffold(
          appBar: buildAppBar(context),
          body: Builder(
            builder: (context) {
              if (vm.isFetching == true) {
                return Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                );
              }

              if (vm.hasError) {
                return const Center(
                  child: Text('No Data Found'),
                );
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildFirstBanner(context, vm),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Const.kPaddingHorizontal,
                            vertical: Const.kPaddingVertical),
                        child: buildFindBestFriend(context),
                      ),
                      buildPremiumMembers(context, vm),
                      buildSecondBanner(context, vm),
                      buildTrustedByUsers(context, vm),
                      buildNewMembers(context, vm),
                      buildHappyStories(context, vm),
                      buildPackages(context, vm),
                      buildReview(context, vm),
                      buildBlogSection(context, vm),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  buildBlogSection(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // blog section
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Const.kPaddingHorizontal,
                ),
                child: InkWell(
                  onTap: () {
                    NavigatorPush.push(page: const BlogPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context).home_9_blog_section,
                        style: Styles.bold_app_accent_22,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Image.asset(
                          'assets/icon/icon_right.png',
                          color: MyTheme.gull_grey,
                          height: 15,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 360,
                child: vm.exploreData.blogs.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: Const.kPaddingHorizontal),
                        scrollDirection: Axis.horizontal,
                        itemCount: vm.exploreData.blogs.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 15,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              NavigatorPush.push(
                                  page: BlogDetails(
                                      blog: vm.exploreData.blogs[index]));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 360,
                                  width: 220,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/220x320.png',
                                      image: vm.exploreData.blogs[index].banner,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Shades.transparent_dark(),
                                Positioned(
                                  bottom: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 14.0),
                                    child: SizedBox(
                                      width: DeviceInfo(context).width * .5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vm.exploreData.blogs[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bold_white_12,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            vm.exploreData.blogs[index]
                                                .categoryName,
                                            style: Styles.italic_light_grey_12,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlogDetails(
                                                            blog: vm.exploreData
                                                                .blogs[index])),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      MyTheme.app_accent_color),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(90.0, 30.0)),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      MyTheme.app_accent_color),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                    side: BorderSide(
                                                        color: MyTheme
                                                            .app_accent_color)),
                                              ),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .view_more,
                                              style: Styles.medium_white_12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : CommonWidget.noData,
              )
            ],
          ),
        )
      ],
    );
  }

  buildReview(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context).home_9_real_reviews,
            style: Styles.bold_app_accent_22,
          ),
        ),
        // real reviews
        const SizedBox(
          height: 10,
        ),

        Container(
          height: 357,
          width: DeviceInfo(context).width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/real_review_back_img.png'),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  child: MyImages.normalImage(vm.exploreData.reviews?.bgImage)),
              vm.exploreData.reviews?.items != null
                  ? CarouselSlider.builder(
                      carouselController: vm.reviewController,
                      itemCount: vm.exploreData.reviews?.items?.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 44,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45.0),
                                  child: SizedBox(
                                    width: 77,
                                    height: 77,
                                    child: MyImages.normalImage(vm.exploreData
                                        .reviews.items[index].image),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  vm.exploreData.reviews.items[index].review,
                                  textAlign: TextAlign.center,
                                  style: Styles.italic_white_14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'assets/icon/icon_qoute.png',
                                height: 35,
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: DeviceInfo(context).height,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        viewportFraction: 0.9,
                        autoPlay: true,
                      ),
                    )
                  : const Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
              // other widgets in the stack
            ],
          ),
        ),
      ],
    );
  }

  buildNewMembers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context).home_9_new_members,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 360,
          child: vm.exploreData.newMembers.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  controller: vm.pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.exploreData.newMembers.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => isLogin
                          ? vm.isFullProfileView &&
                                  (vm.myMembershipType == 'Free')
                              ? MyScaffoldMessenger().sf_messenger(
                                  text: "Please update your package")
                              : NavigatorPush.push(
                                  page: UserPublicProfile(
                                    user: vm.exploreData.newMembers[index],
                                  ),
                                )
                          : CustomPopUp(context).loginDialog(context),
                      child: Stack(
                        children: [
                          Container(
                            height: 360,
                            width: 220,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                child: MyImages.normalImage(
                                    vm.exploreData.newMembers[index].photo)),
                          ),
                          Shades.transparent_dark(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                // height: 150,
                                // width: DeviceInfo(context).width,
                                child: Column(
                                  children: [
                                    // named row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${vm.exploreData.newMembers[index].name}',
                                                style: Styles.bold_white_16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // buildHomePopupMenuButton(items),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    //member id row
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .common_screen_member_id,
                                          style:
                                              TextStyle(color: MyTheme.white),
                                        ),
                                        Text(
                                            '${vm.exploreData.newMembers[index].code}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    // age, height, location and full profile row
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildHappyStories(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            NavigatorPush.push(page: HappyStories());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).home_9_happy_stories,
                  style: Styles.bold_app_accent_22,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Image.asset(
                    'assets/icon/icon_right.png',
                    color: MyTheme.gull_grey,
                    height: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            vm.exploreData.happyStories.isNotEmpty
                ? CarouselSlider.builder(
                    carouselController: vm.happyStoriesController,
                    itemCount: vm.exploreData.happyStories.length,
                    itemBuilder: (context, index, realIndex) {
                      return InkWell(
                        onTap: () {
                          NavigatorPush.push(
                              page: HappyStoriesDetails(
                            data: vm.exploreData.happyStories[index],
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(vm.exploreData
                                        .happyStories[index].thumbImg),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                            ),
                            Shades.transparent_dark(),
                            // title and subtitle of the happy stories
                            Positioned(
                              bottom: 15,
                              right: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // named row
                                      Text(
                                        vm.exploreData.happyStories[index]
                                            .title,
                                        style: Styles.bold_white_16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      //member id row
                                      Text(
                                        vm.exploreData.happyStories[index]
                                            .details,
                                        style: Styles.regular_light_grey_12,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        store.dispatch(SetExploreHappyStoriesCarouselIndex(
                            payload: index));
                      },
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                  )
                : CommonWidget.noData,
            Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                effect: ExpandingDotsEffect(
                    dotColor: Colors.white.withOpacity(0.3),
                    activeDotColor: Colors.white.withOpacity(0.2),
                    dotHeight: 8,
                    dotWidth: 8),
                activeIndex: vm.happyStoriesIndex,
                count: vm.exploreData.happyStories.length ?? 0,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildPackages(BuildContext context, ExploreViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context).home_9_packages,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 385,
          width: DeviceInfo(context).width,
          child: vm.exploreData.packages.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.exploreData.packages.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: vm.exploreData.packages[index].price == 0
                                ? _solitude
                                : _arsenic,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                vm.exploreData.packages[index].image == null
                                    ? const SizedBox(
                                        height: 40,
                                        width: 40,
                                      )
                                    : Image.network(
                                        vm.exploreData.packages[index].image,
                                        height: 40,
                                        width: 40,
                                      ),
                                const SizedBox(
                                  height: 7.3,
                                ),
                                Text(
                                    vm.exploreData.packages[index].price == 0
                                        ? '\$${vm.exploreData.packages[index].price.toString()}'
                                        : '\$${vm.exploreData.packages[index].price.toString()}',
                                    style:
                                        vm.exploreData.packages[index].price ==
                                                0
                                            ? Styles.bold_arsenic_12
                                            : Styles.bold_solitude_12),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(vm.exploreData.packages[index].name,
                                    style: Styles.bold_storm_grey_12),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '\u2022 ${vm.exploreData.packages[index].expressInterest} Express Interests',
                                        style: vm.exploreData.packages[index]
                                                    .price ==
                                                0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${vm.exploreData.packages[index].photoGallery} Gallery Photo Upload',
                                        style: vm.exploreData.packages[index]
                                                    .price ==
                                                0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${vm.exploreData.packages[index].contact} Contact Info View',
                                        style: vm.exploreData.packages[index]
                                                    .price ==
                                                0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    vm.profilePicturePrivacy
                                        ? Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                    '\u2022 ${vm.exploreData.packages[index].profileImageView} Profile Image View',
                                                    style: vm
                                                                .exploreData
                                                                .packages[index]
                                                                .price ==
                                                            0
                                                        ? Styles
                                                            .regular_arsenic_12
                                                        : Styles
                                                            .regular_solitude_12),
                                                const SizedBox(
                                                  height: 14.0,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    vm.galleryPicturePrivacy
                                        ? Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                    '\u2022 ${vm.exploreData.packages[index].galleryImageView} Gallery Image View',
                                                    style: vm
                                                                .exploreData
                                                                .packages[index]
                                                                .price ==
                                                            0
                                                        ? Styles
                                                            .regular_arsenic_12
                                                        : Styles
                                                            .regular_solitude_12),
                                                const SizedBox(
                                                  height: 14.0,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Text('\u2022 Show Auto Profile Match',
                                        style: vm.exploreData.packages[index]
                                                    .price ==
                                                0
                                            ? Styles.regular_arsenic_12
                                            : vm.exploreData.packages[index]
                                                        .autoProfileMatch ==
                                                    1
                                                ? Styles.regular_solitude_12
                                                : vm.exploreData.packages[index]
                                                            .price ==
                                                        0
                                                    ? Styles
                                                        .regular_solitude_12_line_through
                                                    : Styles
                                                        .regular_white_12_line_through),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                        '\u2022 ${vm.exploreData.packages[index].validity} Days',
                                        style: vm.exploreData.packages[index]
                                                    .price ==
                                                0
                                            ? Styles.regular_arsenic_12
                                            : Styles.regular_solitude_12),
                                    const SizedBox(
                                      height: 20.2,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 100,
                                  decoration: vm.exploreData.packages[index]
                                              .packageId !=
                                          1
                                      ? BoxDecoration(
                                          gradient: Styles.buildLinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        )
                                      : BoxDecoration(
                                          color: _color,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                  child: InkWell(
                                    onTap: () {
                                      isLogin
                                          ? vm.exploreData.packages[index]
                                                      .packageId !=
                                                  1
                                              ? NavigatorPush.push(
                                                  page: Payment(
                                                    payment_type:
                                                        "package_payment",
                                                    title: "Package Payment",
                                                    amount: vm.exploreData
                                                        .packages[index].price
                                                        .toDouble(),
                                                    package_id: vm
                                                        .exploreData
                                                        .packages[index]
                                                        .packageId,
                                                  ),
                                                )
                                              : null
                                          : CustomPopUp(context)
                                              .loginDialog(context);
                                    },
                                    child: Center(
                                      child: vm.exploreData.packages[index]
                                                  .packageId ==
                                              1
                                          ? Text(
                                              AppLocalizations.of(context)
                                                  .common_get_started,
                                              style: Styles
                                                  .medium_arsenic_12_line_through,
                                            )
                                          : Text(
                                              AppLocalizations.of(context)
                                                  .common_purchase,
                                              style: Styles.medium_white_12,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : CommonWidget.noData,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildTrustedByUsers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: Const.kPaddingHorizontal, left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context).home_9_trusted_by_users,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 130,
          child: vm.exploreData.trustedByMillions.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.exploreData.trustedByMillions.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: MyTheme.arsenic,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 44,
                              height: 38,
                              child: vm.exploreData.trustedByMillions[index]
                                          .icon !=
                                      null
                                  ? Image.network(vm.exploreData
                                      .trustedByMillions[index].icon)
                                  : const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              vm.exploreData.trustedByMillions[index].title,
                              style: Styles.medium_zircon_14,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildSecondBanner(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              width: DeviceInfo(context).width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: vm.exploreData.banner.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: vm.carouselController2,
                      itemCount: vm.exploreData.banner.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: vm.exploreData.banner[index].photo != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/342x200.png',
                                  image: vm.exploreData.banner[index].photo,
                                  width: DeviceInfo(context).width,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(AppLocalizations.of(context)
                                      .common_no_data)),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          store.dispatch(SetExploreSecondBannerCarouselIndex(
                              payload: index));
                        },
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        viewportFraction: 0.9,
                        autoPlay: true,
                      ),
                    )
                  : CommonWidget.noData,
            ),
            Positioned(
              bottom: 15,
              child: MyAnimatedSmoothIndicator(
                  carouselIndex: vm.carouselIndex2,
                  images: vm.exploreData.banner ?? 0),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildPremiumMembers(BuildContext context, ExploreViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Const.kPaddingHorizontal),
          child: Text(
            AppLocalizations.of(context).home_9_premium_members,
            style: Styles.bold_app_accent_22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // image stack premium members #### premium members
        SizedBox(
          height: 360,
          child: vm.exploreData.premiumMembers.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal),
                  controller: vm.pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.exploreData.premiumMembers.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => isLogin
                          ? vm.isFullProfileView &&
                                  (vm.myMembershipType == 'Free')
                              ? MyScaffoldMessenger().sf_messenger(
                                  text: "Please update your package")
                              : NavigatorPush.push(
                                  page: UserPublicProfile(
                                    user: vm.exploreData.premiumMembers[index],
                                  ),
                                )
                          : CustomPopUp(context).loginDialog(context),
                      child: Stack(
                        children: [
                          Container(
                            height: 360,
                            width: 220,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                child: MyImages.normalImage(vm
                                    .exploreData.premiumMembers[index].photo)),
                          ),
                          Shades.transparent_dark(),
                          Positioned(
                            bottom: 20,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                // height: 150,
                                // width: DeviceInfo(context).width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // named row
                                    Text(
                                      vm.exploreData.premiumMembers[index].name,
                                      style: Styles.bold_white_16,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //member id row
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .common_screen_member_id,
                                          style: const TextStyle(
                                              color: MyTheme.white),
                                        ),
                                        Text(
                                            vm.exploreData.premiumMembers[index]
                                                .code,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    // age, height, location and full profile row

                                    // page navigator with subscribe, love and follow button
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : CommonWidget.noData,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  buildFindBestFriend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).landing_page_title,
          style: Styles.bold_app_accent_30,
        ),
        const SizedBox(
          height: 10,
        ),
        // let's find your life partner to enjoy every moment of your life
        Text(
          AppLocalizations.of(context).landing_page_sub_title,
          style: Styles.regular_arsenic_14,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildFirstBanner(BuildContext context, ExploreViewModel vm) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              width: DeviceInfo(context).width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: vm.exploreData.sliderImages.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: vm.carouselController,
                      itemCount: vm.exploreData.sliderImages.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: vm.exploreData.sliderImages[index].image !=
                                  null
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/342x200.png',
                                  image:
                                      vm.exploreData.sliderImages[index].image,
                                  width: DeviceInfo(context).width,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(AppLocalizations.of(context)
                                      .common_no_data),
                                ),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          store.dispatch(SetExploreFirstBannerCarouselIndex(
                              payload: index));
                        },
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        viewportFraction: 0.9,
                        autoPlay: true,
                      ),
                    )
                  : Center(
                      child: Text(AppLocalizations.of(context).common_no_data),
                    ),
            ),
            Positioned(
              bottom: 10,
              child: MyAnimatedSmoothIndicator(
                  carouselIndex: vm.carouselIndex,
                  images: vm.exploreData.sliderImages ?? 0),
            )
          ],
        ),
        // find your best friend with us
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo/appbar_logo.png',
                  fit: BoxFit.contain,
                  height: 36,
                  width: 46,
                ),
                const SizedBox(
                  width: 8.3,
                ),
                Text(
                  AppConfig.app_name,
                  style: Styles.bold_app_accent_16,
                ),
              ],
            ),
            Row(
              children: [
                CommonWidget.social_button(
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                  icon: "icon_bell.png",
                  onpressed: () {
                    isLogin
                        ? NavigatorPush.push(page: const Notifications())
                        : CustomPopUp(context).loginDialog(context);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                CommonWidget.social_button(
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                  icon: "icon_search.png",
                  onpressed: () {
                    isLogin
                        ? showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const SizedBox(
                                  height: 1000, child: Search());
                            },
                          )
                        : CustomPopUp(context).loginDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreViewModel {
  var exploreData;
  bool isFullProfileView;
  var myMembershipType;
  bool profilePicturePrivacy;
  bool galleryPicturePrivacy;
  String error;
  int carouselIndex;
  int carouselIndex2;
  int happyStoriesIndex;
  final carouselController;
  final carouselController2;
  final happyStoriesController;
  final reviewController;
  final pageController;

  bool isFetching;

  bool get hasError =>
      exploreData == null || store.state.exploreState.error != '';

  ExploreViewModel({
    this.pageController,
    this.reviewController,
    this.happyStoriesController,
    this.happyStoriesIndex,
    this.carouselController,
    this.carouselController2,
    this.carouselIndex,
    this.carouselIndex2,
    this.error,
    this.isFetching,
    this.exploreData,
    this.isFullProfileView,
    this.myMembershipType,
    this.profilePicturePrivacy,
    this.galleryPicturePrivacy,
  });

  static fromStore(Store<AppState> store) {
    return ExploreViewModel(
      isFullProfileView: store.state.featureState.feature?.fullProfileShow,
      myMembershipType: store.state.packageDetailsState.data?.name,
      exploreData: store.state.exploreState.exploreList,
      profilePicturePrivacy:
          store.state.featureState.feature.profilePicturePrivacy == "only_me"
              ? true
              : false,
      galleryPicturePrivacy:
          store.state.featureState.feature.galleryImagePrivacy == "only_me"
              ? true
              : false,
      error: store.state.exploreState.error,
      isFetching: store.state.exploreState.isFetching,
      carouselIndex: store.state.exploreState.carouselIndex,
      carouselIndex2: store.state.exploreState.carouselIndex2,
      carouselController: store.state.exploreState.carouselController,
      carouselController2: store.state.exploreState.carouselController2,
      happyStoriesIndex: store.state.exploreState.happyStoriesIndex,
      happyStoriesController: store.state.exploreState.happyStoriesController,
      reviewController: store.state.exploreState.reviewController,
      pageController: store.state.exploreState.pageController,
    );
  }
}
