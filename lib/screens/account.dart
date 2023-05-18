import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/grid_square_card.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_text_button.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/localization.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/deactivate_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signout_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/change_password.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blogs.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_list.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/manage_profile.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_gallery.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_public_profile.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_shortlist.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_details.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/gallery_picture_view_rqst.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/profile_picture_view_rqst.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earnings.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earnings_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

class Account extends StatefulWidget {
  // final person;

  const Account({Key key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  PageController matched_profile_controller = PageController();
  ScrollController _gridScrollController = ScrollController();

  // from shared preferences
  var _userName = prefs.getString(Const.userName);
  var _userEmail = prefs.getString(Const.userEmail);

  bool formSwitcher = false;
  bool isSupport = store.state.addonState.data.supportTickets;
  bool isReferral = store.state.addonState.data.referralSystem;

  var activation_state;
  bool isSmallScreen = false;

  setScreenSize(wid) {
    setState(() {
      if (DeviceInfo(context).width > 393) {
        isSmallScreen = true;
      } else {
        isSmallScreen = false;
      }
    });
  }

  List<dynamic> _menulist = [
    if (store.state.featureState?.feature?.walletSystem != null &&
        store.state.featureState?.feature.walletSystem)
      GridSquareCard(
        onpressed: MyWallet(),
        icon: "icon_wallet.png",
        isSmallScreen: false,
        text: "My Wallet",
      ),
    GridSquareCard(
      onpressed: ChatList(
        backButtonAppearance: true,
      ),
      icon: "icon_messages.png",
      isSmallScreen: false,
      text: "Messages",
    ),
    GridSquareCard(
      onpressed: Notifications(),
      icon: "icon_notifications.png",
      isSmallScreen: false,
      text: "Notifications",
    ),
    GridSquareCard(
      onpressed: MyInterest(),
      icon: "icon_love.png",
      isSmallScreen: false,
      text: "My Interest",
    ),
    if (store.state.featureState.feature?.profilePicturePrivacy == "only_me")
      GridSquareCard(
        onpressed: PictureProfileViewRqst(),
        icon: "icon_picture_view.png",
        isSmallScreen: false,
        text: LangText(context: OneContext().context)
            .getLocal()
            .profile_picture_screen_appbar_title,
      ),
    if (store.state.featureState.feature?.galleryImagePrivacy == "only_me")
      GridSquareCard(
        onpressed: GalleryProfileViewRqst(),
        icon: "icon_gallery_view.png",
        isSmallScreen: false,
        text: LangText(context: OneContext().context)
            .getLocal()
            .gallery_picture_screen_appbar_title,
      ),
    GridSquareCard(
      onpressed: MyShortlist(),
      icon: "icon_shortlist.png",
      isSmallScreen: false,
      text: "My Shortlist",
    ),
    GridSquareCard(
      onpressed: Ignore(),
      icon: "icon_ignore.png",
      isSmallScreen: false,
      text: "Ignore list",
    ),
    GridSquareCard(
      onpressed: MyHappyStories(),
      icon: "icon_happy_s.png",
      isSmallScreen: false,
      text: "My happy story",
    ),
    GridSquareCard(
      onpressed: BlogPage(),
      icon: "icon_blogs.png",
      isSmallScreen: false,
      text: "Blogs",
    ),
    if (store.state.addonState.data.supportTickets)
      GridSquareCard(
        onpressed: SupportTicket(),
        icon: "icon_support.png",
        isSmallScreen: false,
        text: "Support Ticket",
      ),
    if (store.state.addonState.data.referralSystem)
      GridSquareCard(
        onpressed: Referral(),
        icon: "icon_referral_user.png",
        isSmallScreen: false,
        text: "Referral",
      ),
    if (store.state.addonState.data.referralSystem)
      GridSquareCard(
        onpressed: RefferalEarnings(),
        icon: "icon_referral_earnings.png",
        isSmallScreen: false,
        text: "Ref.. Earnings",
      ),
    if (store.state.addonState.data.referralSystem)
      GridSquareCard(
        onpressed: ReferralEarningsWallet(),
        icon: "icon_referral_wallet.png",
        isSmallScreen: false,
        text: "Ref.. Wallet",
      ),
  ];

  void fnc_deactivate(deactivate, items) {
    if (deactivate) {
      if (items.length == 3) {
        items.removeLast();
        setState(() {
          activation_state = 0;
        });
      }
      items.add("Reactivate Account");
    } else {
      if (items.length == 3) {
        items.removeLast();
      }
      items.add("Deactivate account");
      setState(() {
        activation_state = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wid = DeviceInfo(context).width;
    setScreenSize(wid);
    List<String> items = ['Change Password', 'Logout'];
    if (prefs.getBool(Const.deactivate) != true) {
      prefs.setBool(Const.deactivate, false);
    }
    var deactivate = prefs.getBool(Const.deactivate);
    fnc_deactivate(deactivate, items);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(happyStoryCheckMiddleware()),
      ],
      builder: (_, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              store.dispatch(accountMiddleware());
              store.dispatch(featureCheckMiddleware());
              return Future.delayed(const Duration(seconds: 2));
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // bottom page of the stack
                  buildGradientBoxContainer(context, state, items),
                  buildGridContainer(context, state),

                  /// this section represents only about packages
                  /// upgrade the package go to packages that are available

                  Padding(
                    padding: EdgeInsets.only(
                        left: Const.kPaddingHorizontal,
                        right: Const.kPaddingHorizontal,
                        bottom: 20),
                    child: buildPackageDetails(context, state),
                  ),

                  /// match profile box
                  Padding(
                    padding: EdgeInsets.only(
                        left: Const.kPaddingHorizontal,
                        right: Const.kPaddingHorizontal,
                        bottom: Const.kPaddingVertical),
                    child: buildMatchProfileContainer(context, state),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGradientBoxContainer(mainContext, AppState state, items) {
    return Container(
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
          child: Container(
            child: Column(
              children: [
                /// image name email and other more vertz field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: MyImages.normalImage(
                                state.accountState.profileData?.memberPhoto),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: Styles.bold_white_14,
                            ),
                            Text(
                              _userEmail,
                              style: Styles.regular_white_12,
                            )
                          ],
                        )
                      ],
                    ),
                    buildHomePopupMenuButton(mainContext, items),
                  ],
                ),

                /// common white back widgets
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// public profile
                      /// this will go to mypublic profile
                      /// which is myPublicProfie

                      MyTextButton(
                        text: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .profile_screen_public_profile,
                            style: Styles.regularWhite(context, 3),
                            // style: Styles.regular_white_12
                          ),
                        ),
                        onPressed: () =>
                            NavigatorPush.push(page: MyPublicProfile()),
                      ),

                      /// manage profile
                      /// this will go to my profile
                      /// which is my profile

                      MyTextButton(
                        onPressed: () => NavigatorPush.push(page: MyProfile()),
                        text: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .profile_screen_manage_profile,
                            style: Styles.regularWhite(context, 3),
                            // style: Styles.regular_white_12
                          ),
                        ),
                      ),

                      /// gallery
                      /// this will go to my gallery
                      /// which is mygallery

                      MyTextButton(
                        onPressed: () {
                          NavigatorPush.push(page: MyGallery());
                        },
                        text: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            AppLocalizations.of(context).profile_screen_gallery,
                            style: Styles.regularWhite(context, 3),
                            // style: Styles.regular_white_12
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 15,
                ),

                /// horzontal line
                Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(0.50),
                ),
                const SizedBox(
                  height: 15,
                ),

                /// remaining boxes in are below
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.common_remaining_box(
                            context: context,
                            localization_text: AppLocalizations.of(context)
                                .profile_screen_r_interest,
                            value: state
                                .accountState.profileData?.remainingInterest),
                        CommonWidget.common_remaining_box(
                            context: context,
                            localization_text: AppLocalizations.of(context)
                                .profile_screen_r_contact_view,
                            value: state.accountState.profileData
                                ?.remainingContactView),
                        CommonWidget.common_remaining_box(
                            context: context,
                            localization_text: AppLocalizations.of(context)
                                .profile_screen_r_gallery_image_upload,
                            value: state.accountState.profileData
                                ?.remainingPhotoGallery),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        state.accountState.profileData
                                    ?.remainingProfileImageView !=
                                ""
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .profile_screen_r_profile_image_view,
                                      style: Styles.regular_white_12,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      state.accountState.profileData
                                          ?.remainingProfileImageView
                                          .toString(),
                                      style: Styles.medium_white_22,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        state.accountState.profileData
                                    ?.remainingGalleryImageView !=
                                ""
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .profile_screen_r_gallery_image_view,
                                      style: Styles.regular_white_12,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      state.accountState.profileData
                                          ?.remainingGalleryImageView
                                          .toString(),
                                      style: Styles.medium_white_22,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridContainer(BuildContext context, AppState state) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _menulist.length,
        controller: _gridScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            childAspectRatio: 1),
        padding: EdgeInsets.only(left: 24.0, top: 20, right: 24),
        itemBuilder: (context, index) {
          return GridSquareCard(
            onpressed: _menulist[index].onpressed,
            icon: _menulist[index].icon,
            isSmallScreen: _menulist[index].isSmallScreen,
            text: _menulist[index].text,
          );
        });
  }

  Widget buildPackageDetails(BuildContext context, AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.app_accent_color),
        color: MyTheme.solitude,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      // height: 111,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 15.0, right: 8.0, bottom: 15.0),
        child: Column(
          children: [
            /// package and upgrade package-------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).profile_screen_package,
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState.profileData?.currentPackageInfo
                                  ?.packageName ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).profile_screen_expire_on,
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState.profileData?.currentPackageInfo
                                  ?.packageExpiry ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                  ],
                ),
                // package list
                MyTextButton(
                  onPressed: () {
                    NavigatorPush.push(page: PremiumPlans());
                  },
                  text: Text(
                    AppLocalizations.of(context).profile_screen_upgrade,
                    style: Styles.bold_white_10,
                  ),
                  color: MyTheme.app_accent_color,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // package details button
                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)
                          .profile_screen_package_details,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    page: PackageDetails(),
                  ),
                ),
                // package history button

                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)
                          .profile_screen_package_history,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    page: PackageHistory(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildMatchProfileContainer(BuildContext context, AppState state) {
    return Container(
      height: 140,
      decoration: build_matched_profile_box_decoration(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 14.0, bottom: 10, top: 21, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).chat_list_matched_profile,
              style: Styles.bold_white_12,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 72,
              child: state.accountState.profileData?.matchedProfiles != null &&
                      state.accountState.profileData.matchedProfiles.isNotEmpty
                  ? PageView.builder(
                      controller: matched_profile_controller,
                      itemCount:
                          state.accountState.profileData.matchedProfiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => NavigatorPush.push(
                              page: UserPublicProfile(
                            user: state.accountState.profileData
                                .matchedProfiles[index],
                          )),
                          child: Row(
                            children: [
                              Container(
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  image: DecorationImage(
                                    image: state.accountState.profileData
                                                .matchedProfiles[index].photo ==
                                            ''
                                        ? NetworkImage(
                                            'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=')
                                        : NetworkImage(
                                            '${state.accountState.profileData.matchedProfiles[index].photo}'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${state.accountState.profileData.matchedProfiles[index].name}',
                                      style: Styles.bold_white_14,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.accountState.profileData.matchedProfiles[index].age.toString()} yrs, ${state.accountState.profileData.matchedProfiles[index].height.toString()} feet, ${state.accountState.profileData.matchedProfiles[index].maritalStatus ?? ''},',
                                          style: Styles.regular_white_12,
                                        ),
                                        Text(
                                          ''
                                          '${state.accountState.profileData.matchedProfiles[index].religion}, ${state.accountState.profileData.matchedProfiles[index].caste}',
                                          style: Styles.regular_white_12,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                      AppLocalizations.of(context).common_no_data,
                      style: TextStyle(color: Colors.white),
                    )),
            )
          ],
        ),
      ),
    );
  }

  /// pop up menu details page

  Widget buildHomePopupMenuButton(mainContext, List items) {
    return Container(
      height: 25,
      width: 15,
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 20,
        ),
        onSelected: (value) {
          switch (value.toString().toLowerCase()) {
            case 'change password':
              NavigatorPush.push(page: ChangePassword());
              break;

            case 'deactivate account':
              _dialogBuilder(
                mainContext,
              );
              break;

            case 'reactivate account':
              store.dispatch(deactivateMiddleware(
                  context: mainContext, deactivate_status: 0));
              prefs.remove('_deactivate');
              prefs.setBool(Const.deactivate, false);

              break;

            case 'logout':
              store.dispatch(signOutMiddleware(context));
              break;
          }
        },
        itemBuilder: (context) {
          return items
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
              .toList();
        },
      ),
    );
  }

  _dialogBuilder(mainContext) {
    return showDialog<void>(
      context: mainContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(AppLocalizations.of(context).deactivate,
                    textAlign: TextAlign.center,
                    style: Styles.bold_app_accent_20),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: Styles.buildLinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: TextButton(
                        onPressed: () {
                          store.dispatch(deactivateMiddleware(
                              context: mainContext,
                              deactivate_status: activation_state));
                          prefs.remove('_deactivate');
                          prefs.setBool(Const.deactivate, true);

                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(90.0, 45.0)),
                          overlayColor: MaterialStateProperty.all(
                              MyTheme.app_accent_color),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                                side: BorderSide(
                                    color: MyTheme.app_accent_color)),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).yes,
                          style: Styles.bold_arsenic_16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(90.0, 45.0)),
                        overlayColor:
                            MaterialStateProperty.all(MyTheme.app_accent_color),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                              side:
                                  BorderSide(color: MyTheme.app_accent_color)),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context).no,
                        style: Styles.bold_arsenic_16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration build_matched_profile_box_decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: [
          MyTheme.gradient_color_1,
          MyTheme.gradient_color_2,
        ],
      ),
    );
  }
}
