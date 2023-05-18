import 'dart:io';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/container_with_icon.dart';
import 'package:active_matrimonial_flutter_app/custom/custom_popup.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_circular_indicator.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/report/report_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/add_shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/search.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // page view controller
  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 1);
  final TextEditingController _reportController = TextEditingController();

  bool isLogin = prefs.getBool("isLogin") ?? false;

  // page view page number
  int current_page = 0;

  goNextPage() {
    controller.animateToPage(
      current_page + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  goPrevPage() {
    controller.animateToPage(
      current_page - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  onRefresh() {
    store.dispatch(accountMiddleware());
    store.dispatch(homeMiddleware());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    store.dispatch(accountMiddleware());
  }

  @override
  void dispose() {
    controller.dispose();
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, HomeViewModel vm) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await OneContext().showDialog<bool>(
            builder: (BuildContext context) {
              return exit_alert_dialog(context);
            },
          );
          return shouldPop;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(context),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  onRefresh();
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: DeviceInfo(context).height -
                        (AppBar().preferredSize.height + 100),
                    padding: EdgeInsets.only(
                        left: Const.kPaddingHorizontal,
                        right: Const.kPaddingHorizontal,
                        bottom: Const.kPaddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),

                        // main  container with image
                        if (vm.activeMembers == null || vm.activeMembers == [])
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: MyTheme.app_accent_color),
                            onPressed: () {
                              onRefresh();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Something went wrong reload it"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.refresh),
                              ],
                            ),
                          )
                        else
                          vm.isFetch == false
                              ? view_card(vm, context)
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: MyTheme.storm_grey,
                                  ),
                                ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            // bottom navigation bar
            // bottomNavigationBar: buildBottomNavigationContainer(context),
            ),
      ),
    );
  }

  Widget view_card(HomeViewModel vm, BuildContext context) {
    return Expanded(
      child: vm.activeMembers.isNotEmpty
          ? PageView.builder(
              controller: controller,
              itemCount: vm.activeMembers.length,
              itemBuilder: (listViewContext, index) {
                var members = vm.activeMembers;
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: MyImages.normalImage(members[index].photo),
                        ),
                      ),

                      /// transparent and black shade over image
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.4,
                                  1,
                                ],
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 150,
                            width: DeviceInfo(context).width,
                            child: Column(
                              children: [
                                // named row
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            members[index].name == ''
                                                ? Text('')
                                                : Text(
                                                    '${members[index].name}',
                                                    style: Styles.bold_white_16,
                                                  ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            members[index].membership == 2
                                                ? ImageIcon(
                                                    const AssetImage(
                                                        'assets/icon/icon_premium.png'),
                                                    size: 18,
                                                    color: MyTheme
                                                        .icon_premium_color,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),

                                      /// pop up menu button
                                      /// might not here in future
                                      buildPopupMenuButton(
                                          user: vm.activeMembers[index], vm: vm)
                                    ],
                                  ),
                                ),
                                //member id row
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .common_screen_member_id,
                                      style:
                                          const TextStyle(color: MyTheme.white),
                                    ),
                                    Text(members[index].code,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                // age, height, location and full profile row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/icon_person.png'),
                                              size: 12,
                                              color: MyTheme.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),

                                            // age and height row
                                            Text(
                                              // TODO INch WILL BE HERE
                                              '${members[index].age} yrs, ${members[index].height} ft',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const ImageIcon(
                                              AssetImage(
                                                  'assets/icon/icon_location.png'),
                                              size: 12,
                                              color: MyTheme.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${members[index].country}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),

                                    /// full profile button
                                    TextButton(
                                      onPressed: () {
                                        vm.isFullProfileView &&
                                                (vm.myMembershipType == 'Free')
                                            ? MyScaffoldMessenger().sf_messenger(
                                                text:
                                                    "Please update your package")
                                            : NavigatorPush.push(
                                                page: UserPublicProfile(
                                                  user: members[index],
                                                ),
                                              );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white.withOpacity(0.1)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white)),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .home_screen_full_profile,
                                        style: Styles.bold_white_12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceInfo(context).height * 0.01,
                                ),
                                // page navigator with subscribe, love and follow button
                                buildPageNavigatorWithSubscribeLoveFollow(
                                    context, index, members[index], vm),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  current_page = index;
                });
                prefs.setBool(Const.showDialog, false);
              },
            )
          : Center(
              child: Text(AppLocalizations.of(context).common_no_data),
            ),
    );
  }

  AlertDialog exit_alert_dialog(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).exit,
          style: Styles.bold_arsenic_14),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () {
            // Navigator.pop(context, true);
            Platform.isAndroid ? SystemNavigator.pop() : exit(0);
          },
          child: Text('Yes', style: Styles.regular_arsenic_14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('No', style: Styles.regular_arsenic_14),
        ),
      ],
    );
  }

  Widget buildPopupMenuButton({var user, HomeViewModel vm}) {
    return Container(
      alignment: Alignment.centerRight,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        child: const SizedBox(
          width: 16,
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
        onSelected: (value) {
          switch (value.toString().toLowerCase()) {
            case 'report':
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildAlertDialog(context, user, vm);
                },
              );

              break;
          }
        },
        itemBuilder: (context) {
          return ['Report']
              .map((e) => PopupMenuItem(
                  height: 30,
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(color: Colors.black),
                  )))
              .toList();
        },
      ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, user, HomeViewModel vm) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).common_report_member,
        style: Styles.bold_arsenic_14,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context).common_report_reason,
            style: Styles.regular_arsenic_14,
          ),
          TextField(
            maxLines: 5,
            controller: _reportController,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyTheme.solitude,
              border: InputBorder.none,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(
            AppLocalizations.of(context).common_cancel,
            style: Styles.regular_arsenic_14,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(AppLocalizations.of(context).common_report,
              style: Styles.regular_arsenic_14),
          onPressed: () {
            vm.userReport(user: user.userId, reason: _reportController.text);
            Navigator.of(context).pop();
            _reportController.clear();
          },
        ),
      ],
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
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
                          ? NavigatorPush.push(page: Notifications())
                          : CustomPopUp(context).loginDialog(context);
                    }),
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
                                return SizedBox(height: 1000, child: Search());
                              })
                          : CustomPopUp(context).loginDialog(context);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageNavigatorWithSubscribeLoveFollow(
      BuildContext context, int index, dynamic user, HomeViewModel vm) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      /// go to left
      ContainerWithIcon(
        onpressed: () {
          goPrevPage();
        },
        icon: 'icon_left.png',
        width: 42,
        height: 42,
        radius: 20,
        opacity: 0.1,
        color: Colors.white,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// add to ignore
            ContainerWithIcon(
              onpressed: () {
                vm.ignoreUser(user: user);
              },
              icon: 'icon_ignore.png',
              width: 42,
              height: 42,
              radius: 20,
              gradient: Styles.buildLinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            SizedBox(
              width: DeviceInfo(context).width * 0.05,
            ),

            vm.packageExpire != "Expired"
                ? vm.myInterestStateLoading == false
                    ? ContainerWithIcon(
                        onpressed: () {
                          (vm.isFullProfileView &&
                                  (vm.myMembershipType == 'Free'))
                              ? MyScaffoldMessenger().sf_messenger(
                                  text: "Please update your package")
                              : vm.expressInterest(user: user);
                        },
                        icon: 'icon_love.png',
                        width: 42,
                        height: 42,
                        radius: 20,
                        isChecked:
                            vm.activeMembers[index].interestStatus == '1',
                        gradient: Styles.buildLinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight))
                    : MyCircularIndicator(
                        width: 42,
                        height: 42,
                        radius: 20,
                        gradient: Styles.buildLinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      )
                : ContainerWithIcon(
                    onpressed: () {
                      MyScaffoldMessenger()
                          .sf_messenger(text: 'Please update your package');
                    },
                    icon: 'icon_love.png',
                    width: 42,
                    height: 42,
                    radius: 20,
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight)),
            SizedBox(
              width: DeviceInfo(context).width * 0.05,
            ),

            /// add to shortlist
            vm.shortlistStateLoading == false
                ? ContainerWithIcon(
                    onpressed: () {
                      vm.addShortlist(user: user.userId);
                    },
                    icon: 'icon_subscribe.png',
                    width: 42,
                    height: 42,
                    radius: 20,
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight),
                  )
                : MyCircularIndicator(
                    width: 42,
                    height: 42,
                    radius: 20,
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
          ],
        ),
      ),
      ContainerWithIcon(
        onpressed: () {
          goNextPage();
        },
        icon: 'icon_right.png',
        width: 42,
        height: 42,
        radius: 20,
        opacity: 0.1,
        color: Colors.white,
      ),
    ]);
  }
}

class HomeViewModel {
  bool isFullProfileView;
  List activeMembers;
  var isFetch;
  var packageExpire;
  var myInterestStateLoading;
  var shortlistStateLoading;
  var myMembershipType;
  var isShortListed;
  var isInterested;
  void Function({dynamic user, dynamic reason}) userReport;
  void Function({dynamic user}) addShortlist;
  void Function({dynamic user}) expressInterest;
  void Function({dynamic user}) ignoreUser;

  HomeViewModel(
      {this.packageExpire,
      this.isFetch,
      this.activeMembers,
      this.isFullProfileView,
      this.myInterestStateLoading,
      this.shortlistStateLoading,
      this.userReport,
      this.addShortlist,
      this.expressInterest,
      this.ignoreUser,
      this.myMembershipType,
      this.isInterested,
      this.isShortListed});

  static fromStore(Store<AppState> store) {
    return HomeViewModel(
      isFullProfileView: store.state.featureState.feature?.fullProfileShow,
      activeMembers: store.state.homeState.homeDataList,
      isFetch: store.state.homeState.isFetching,
      packageExpire: store
          .state.accountState.profileData?.currentPackageInfo?.packageExpiry,
      myInterestStateLoading: store.state.myInterestState?.isLoading,
      shortlistStateLoading: store.state.shortlistState?.isLoading,
      myMembershipType: store.state.packageDetailsState.data?.name,

      /// functions
      userReport: ({dynamic user, dynamic reason}) =>
          store.dispatch(reportMiddleware(userId: user, reason: reason)),

      addShortlist: ({dynamic user}) =>
          store.dispatch(addShortlistMiddleware(userId: user)),
      expressInterest: ({dynamic user}) =>
          store.dispatch(expressInterestMiddleware(user: user)),

      ignoreUser: ({dynamic user}) => store.dispatch(AddToIgnoreListFromHome(
        user: user,
      )),
    );
  }
}
