import 'dart:core';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/public_profile_list.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/public_profile/public_profile_middleware.dart';
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
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_mycontact_details.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_personal_n_attitude.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_pertner_expectation.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_present_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_residency_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_spiritual_n_social.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../custom/full_screen_image_viewer.dart';

class MyPublicProfile extends StatefulWidget {
  const MyPublicProfile({Key key}) : super(key: key);

  @override
  State<MyPublicProfile> createState() => _MyPublicProfileState();
}

class _MyPublicProfileState extends State<MyPublicProfile> {
  var userId = prefs.getInt(Const.userId).toString();
  var userName = prefs.getString(Const.userName);
  var userEmail = prefs.getString(Const.userEmail);
  var userAge = prefs.getString(Const.userAge);
  var userHeight = prefs.getString(Const.userHeight);
  var userMaritalStatus = prefs.getString(Const.maritalStatus);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        store.dispatch(Reset.publicProfile),
        store.dispatch(publicProfileMiddleware(userId: userId)),
        // store.dispatch(galleryImageMiddleware()),
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
                    buildGradientLayout(context, state),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildListViewSeparated(state),
                          PP_PartnerExpectation(),
                          buildGallery(state),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildGallery(AppState state) {
    return Container(
      child: state.publicProfileState.photogallery.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10,
              ),
              child: MasonryGridView.count(
                padding: EdgeInsets.zero,
                itemCount: state.publicProfileState.photogallery.length,
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
                              .publicProfileState
                              .photogallery[index]
                              .imagePath),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      child: Image.network(
                        state.publicProfileState.photogallery[index].imagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: Text('No Data Found'),
            ),
    );
  }

  Widget buildListViewSeparated(AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal, left: Const.kPaddingHorizontal),
        child: ListView(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyProfileListData(
              title2: "About",
              subtitle2: 'On Behalf: Selfs',
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
              pp2: PP_MyContactDetails(),
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
              title2: "Hobbies And Interest",
              icon2: 'assets/icon/icon_hobbiesInterest.png',
              pp2: PP_HobbiesInterest(),
            ).getExpandableWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
              title2: "Personal Attitude And Behavior",
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
              title2: "Spiritual And Social Background",
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

  Widget buildGradientLayout(BuildContext context, AppState state) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          // linear gradient
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter),
          // border radius and stuff
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
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
                      CircleAvatar(
                        radius: 25,
                        foregroundImage:
                            state.accountState.profileData.memberPhoto == null
                                ? const AssetImage(
                                    'assets/images/default_avater.png')
                                : NetworkImage(
                                    state.accountState.profileData.memberPhoto),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: Styles.bold_white_14,
                          ),
                          Text(
                            userEmail,
                            style: Styles.regular_white_12,
                          )
                        ],
                      )
                    ],
                  ),
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
                height: 20,
              ),

              /// remaining boxes in are below
              Row(
                children: [
                  Text(
                    '$userAge years, $userHeight ft, $userMaritalStatus',
                    style: Styles.regular_white_10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: NavigationButton(
                      text: 'Full Profile',
                    ),
                  ),
                  Tab(
                    child: NavigationButton(
                      text: 'Partner Preferences',
                    ),
                  ),
                  Tab(
                    child: NavigationButton(
                      text: 'Gallery',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
