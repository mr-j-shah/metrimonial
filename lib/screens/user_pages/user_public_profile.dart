import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/custom/public_profile_list.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_picture_view_request/gallery_picture_view_request_send.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/add_ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_request_send.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/add_shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_astronomic_Info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_basic_information.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_career_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_education_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_family_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_hobbies_n_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_introduction.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_language.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_life_style.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_personal_n_attitude.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_pertner_expectation.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_present_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_residency_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_spiritual_n_social.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_usercontact_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../custom/full_screen_image_viewer.dart';
import '../../redux/libs/report/report_middleware.dart';

class UserPublicProfile extends StatefulWidget {
  final user;

  const UserPublicProfile({Key key, this.user}) : super(key: key);

  @override
  State<UserPublicProfile> createState() => _UserPublicProfileState();
}

class _UserPublicProfileState extends State<UserPublicProfile> {
  TextEditingController _reportController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.publicProfile),

        store.dispatch(publicProfileMiddleware(userId: widget.user.userId)),
        // store.dispatch(AddShortlistReset())
      ],
      builder: (_, state) => DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          body: state.publicProfileState.isFetching
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                )
              : Column(
                  children: [
                    buildContainerGradient(context, state),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildListView(context, state),
                          PP_PartnerExpectation(),
                          buildgallery(context, state)
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildgallery(mainContext, AppState state) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 10, top: 10.0),
      child: Stack(
        children: [
          MasonryGridView.count(
            padding: EdgeInsets.zero,
            itemCount: state.publicProfileState.photogallery?.length,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullScreenImageViewer(state
                            .publicProfileState.photogallery[index].imagePath)),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: MyImages.normalImage(
                      state.publicProfileState.photogallery[index].imagePath),
                ),
              );
            },
          ),
          state.featureState.feature.galleryImagePrivacy == "only_me"
              ? gallery_check(state, mainContext)
              : Container(),
        ],
      ),
    );
  }

  Widget gallery_check(AppState state, mainContext) {
    return Container(
      child: widget.user.galleryViewRequestStatus ||
              state.publicProfileState.photogallery.isEmpty
          ? Container()
          : Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/icon_lock.png',
                    color: MyTheme.arsenic,
                    height: 25,
                    width: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      state.accountState.profileData.currentPackageInfo
                                      .packageExpiry ==
                                  "Expired" ||
                              state.accountState.profileData
                                      .remainingGalleryImageView ==
                                  0
                          ? MyScaffoldMessenger()
                              .sf_messenger(text: "Please Upgrade your Package")
                          : showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Gallery Image View',
                                    style: Styles.bold_arsenic_14,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Text(
                                        "Remaining Gallery Picture View: ${state.accountState.profileData.remainingGalleryImageView} times",
                                        textAlign: TextAlign.center,
                                        style: Styles.regular_gull_grey_12,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "N.B. Requesting to See This Member Galllery Picture Will Cost 1 From Remaining Gallery Picture View.",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        backgroundColor: MyTheme.zircon,
                                      ),
                                      child: Text(
                                        'Close',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            gradient:
                                                Styles.buildLinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end:
                                                        Alignment.centerRight)),
                                        child: Text(
                                          'Confirm',
                                          style:
                                              TextStyle(color: MyTheme.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        store.dispatch(
                                            sendGalleryPictureViewRequestAction(
                                          id: widget.user.userId,
                                        ));
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Text(
                        'Send Gallery Photo View Request',
                        style: Styles.bold_white_12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: Styles.buildLinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildListView(BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal,
            left: Const.kPaddingHorizontal,
            bottom: 10),
        child: ListView(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyProfileListData(
              title2: "About",
              subtitle2:
                  "On Behalf ${state.publicProfileState.basic?.onbehalf?.name}",
              icon2: 'assets/icon/icon_left_qoute.png',
              pp2: PP_Information(),
            ).getExpandableWidget(context, index: 0),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Basic Information",
              icon2: 'assets/icon/icon_basicInfo.png',
              pp2: PP_BasicInformation(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Contact Details",
              icon2: 'assets/icon/icon_contactDetails.png',
              pp2: PP_UserContactDetails(userid: widget.user.userId),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Location",
              icon2: 'assets/icon/icon_presentAddress.png',
              pp2: PP_PresentAddress(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Education Details",
              icon2: 'assets/icon/icon_educationCareer.png',
              pp2: PP_EducationInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Career Details",
              icon2: 'assets/icon/icon_educationCareer.png',
              pp2: PP_CareerInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Physical Attributes",
              icon2: 'assets/icon/icon_physicalAttri.png',
              pp2: PP_PhysicalAttributes(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Language",
              icon2: 'assets/icon/icon_language.png',
              pp2: PP_Language(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Hobbies & Interest",
              icon2: 'assets/icon/icon_hobbiesInterest.png',
              pp2: PP_HobbiesInterest(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Personal Attitude & Behavior",
              icon2: 'assets/icon/icon_personalAttitude.png',
              pp2: PP_PersonalAttitude(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Residency Information",
              icon2: 'assets/icon/icon_residency.png',
              pp2: PP_ResidencyInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Spiritual & Social Background",
              icon2: 'assets/icon/icon_spiritualSocial.png',
              pp2: PP_SpiritualSocial(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Life Style",
              icon2: 'assets/icon/icon_lifeStyle.png',
              pp2: PP_LifeStyle(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Astronomic Information",
              icon2: 'assets/icon/icon_astronomy.png',
              pp2: PP_AstronomicInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Permanent Address",
              icon2: 'assets/icon/icon_permanentAddress.png',
              pp2: PP_PermanentAddress(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Family Information",
              icon2: 'assets/icon/icon_family.png',
              pp2: PP_FamilyInfo(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reportDialogBuilder(BuildContext maincontext, AppState state) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    hintText:
                        AppLocalizations.of(context).common_report_reason),
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
              child: Text(
                AppLocalizations.of(context).common_report,
                style: Styles.regular_arsenic_14,
              ),
              onPressed: () {
                store.dispatch(reportMiddleware(
                    userId: widget.user.userId,
                    reason: _reportController.text));
                Navigator.of(context).pop();
                _reportController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildContainerGradient(mainContext, AppState state) {
    return Container(
      height: 393,
      decoration: BoxDecoration(
          // linear gradient
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              MyTheme.gradient_color_1,
              MyTheme.gradient_color_2,
            ],
          ),
          // border radius and stuff
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0))),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 22.0, left: 22.0, top: 10),
          child: Column(
            children: [
              /// image name email and other more vertz field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/icon/icon_pop_white.png',
                            height: 20,
                            width: 20,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      if (state.featureState.feature.profilePicturePrivacy ==
                          "only_me")
                        only_me_check(mainContext, state)
                      else
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: MyImages.normalImage(widget.user.photo),
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.publicProfileState.basic?.firsName ?? '',
                            style: Styles.bold_white_14,
                          ),
                          Text(
                            state.publicProfileState.contact.email,
                            style: Styles.regular_white_12,
                          )
                        ],
                      ),
                    ],
                  ),

                  /// love
                  IconButton(
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      state.accountState.profileData.currentPackageInfo
                                      .packageExpiry !=
                                  "Expired" &&
                              store.state.accountState.profileData
                                      .remainingInterest !=
                                  0
                          ? store.dispatch(
                              expressInterestMiddleware(
                                user: widget.user,
                              ),
                            )
                          : MyScaffoldMessenger().sf_messenger(
                              text: "Please Upgrade your Package");
                    },
                    icon: state.myInterestState.isLoading
                        ? CircularProgressIndicator(
                            color: MyTheme.storm_grey,
                          )
                        : Image.asset('assets/icon/icon_pp_love.png'),
                  )
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              /// horzontal line
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(.50),
              ),

              const SizedBox(
                height: 10,
              ),

              /// remaining boxes in are below
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.user.age} yrs, ${widget.user.height} ft, ${state.publicProfileState.basic?.maritialStatus}",
                        style: Styles.regular_white_12,
                      ),
                      Text(
                        "${state.publicProfileState.spiritual == null ? '' : state.publicProfileState.spiritual.religionId + " " ?? ""} ${state.publicProfileState.spiritual == null ? '' : state.publicProfileState.spiritual.casteId ?? ""}",
                        style: Styles.regular_white_12,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).public_profile,
                        style: Styles.regular_white_12,
                      ),
                      Text("${state.publicProfileState.profilematch ?? 0} %",
                          style: Styles.bold_white_30)
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              const TabBar(
                  isScrollable: true,
                  //physics: NeverScrollableScrollPhysics(),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: NavigationButton(
                        text: 'Full profile',
                      ),
                    ),
                    Tab(
                        child: NavigationButton(
                      text: 'Partner Preferences',
                    )),
                    Tab(
                        child: NavigationButton(
                      text: 'Gallery',
                    )),
                  ]),
              const SizedBox(
                height: 18,
              ),

              /// horzontal line 2
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(.50),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _reportDialogBuilder(context, state);
                        },
                        child: CommonWidget.social_button(
                            icon: 'icon_report.png',
                            width: 42,
                            height: 42,
                            color: Colors.white,
                            radius: 32),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.user.reportStatus != true
                            ? AppLocalizations.of(context).my_profile_report
                            : AppLocalizations.of(context).my_profile_reported,
                        style: Styles.medium_white_12,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CommonWidget.social_button(
                          onpressed: () {
                            store.dispatch(addShortlistMiddleware(
                                userId: widget.user.userId));
                          },
                          icon: 'icon_shortlist_black.png',
                          width: 42,
                          height: 42,
                          color: Colors.white,
                          radius: 32),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.user.shortlistStatus == 1 ||
                                state.shortlistState.addShortlistResponse.result
                            ? AppLocalizations.of(context).common_shortlisted
                            : AppLocalizations.of(context).common_shortlist,
                        style: Styles.medium_white_12,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CommonWidget.social_button(
                          onpressed: () => store.dispatch(addIgnoreMiddleware(
                              user: widget.user, from: 'userprofile')),
                          // AddIgnoreAction(user: widget.user)),
                          icon: 'icon_ignore_users.png',
                          width: 42,
                          height: 42,
                          color: Colors.white,
                          radius: 32),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).my_profile_ignore_users,
                        style: Styles.medium_white_12,
                      ),
                    ],
                  ),
                ],
              )

              // horizontal line end
            ],
          ),
        ),
      ),
    );
  }

  Widget only_me_check(mainContext, AppState state) {
    return InkWell(
      onTap: () {
        state.accountState.profileData.currentPackageInfo.packageExpiry ==
                    "Expired" ||
                state.accountState.profileData.remainingProfileImageView == 0
            ? MyScaffoldMessenger()
                .sf_messenger(text: 'Please update your package')
            : showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Profile Picture View',
                      style: Styles.bold_arsenic_14,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Text(
                          "Remaining Profile Picture View: ${state.accountState.profileData.remainingProfileImageView} times",
                          textAlign: TextAlign.center,
                          style: Styles.regular_gull_grey_12,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "N.B. Requesting to See This Member Profile Picture Will Cost 1 From Remaining Profile Picture View.",
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          backgroundColor: MyTheme.zircon,
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: Styles.buildLinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: MyTheme.white),
                          ),
                        ),
                        onPressed: () {
                          store.dispatch(sendProfilePictureViewRequestAction(
                              id: widget.user.userId));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(widget.user.photo),
          ),
          widget.user.profileViewRequestStatus
              ? Container()
              : Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        'assets/icon/icon_lock.png',
                        color: MyTheme.arsenic,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final color;
  final text;

  const NavigationButton({Key key, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Text(
            text,
            style: Styles.regular_white_12,
          ),
        ),
      ),
    );
  }
}
