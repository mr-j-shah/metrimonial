import 'dart:io';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/custom/percentage_calculator.dart';
import 'package:active_matrimonial_flutter_app/custom/public_profile_list.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/gallery_image/gallery_image_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/career_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/contact_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/education_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/partnerExpectationGetMiddleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/permanent_address_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/state_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/sub_caste_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/partner_expectation_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/manage_profile_combine_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/partner_expectation_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/my_happy_story/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/astronomic_info.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/basic_information.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/career_info.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/family_info.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/introduction.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_astronomic_Info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_basic_information.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_career_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_family_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_hobbies_n_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_introduction.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/astronomic_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/attitude_interest_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/basic_info_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/family_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/hobbies_interest_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/introduction_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/language_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/life_style_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/physical_attributes_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/present_address_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/residency_get_middleware.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/spiritual_social_get_middleware.dart';
import '../public_profile_expandable_cards/pp_education_info.dart';
import '../public_profile_expandable_cards/pp_language.dart';
import '../public_profile_expandable_cards/pp_life_style.dart';
import '../public_profile_expandable_cards/pp_personal_n_attitude.dart';
import '../public_profile_expandable_cards/pp_present_address.dart';
import '../public_profile_expandable_cards/pp_residency_info.dart';
import '../public_profile_expandable_cards/pp_spiritual_n_social.dart';
import '../public_profile_expandable_cards/pp_usercontact_details.dart';
import 'attitude_interests.dart';
import 'contact_details.dart';
import 'education_info.dart';
import 'hobbies_n_interest.dart';
import 'language.dart';
import 'life_style.dart';
import 'present_address.dart';
import 'residency_info.dart';
import 'spiritual_n_social.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var _userName = prefs.getString(Const.userName);
  var _userEmail = prefs.getString(Const.userEmail);
  var _userAge = prefs.getString(Const.userAge).toString();
  var _userHeight = prefs.getString(Const.userHeight).toString();
  var _userMaritalStatus = prefs.getString(Const.maritalStatus);

  final _formKey = GlobalKey<FormState>();

  ImagePicker _picker = ImagePicker();
  File _image;
  var _img_name;

  Future getImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporay = File(image.path);

      setState(() {
        _image = imageTemporay;
        _img_name = imageTemporay.path.split('/').last;
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        !store.state.manageProfileCombineState.profiledropdownResponseData
                .result
            ? store.dispatch(profiledropdownMiddleware())
            : null,
        store.dispatch(UpdateTab(0)),
        store.dispatch(introductionGetMiddleware()),
        store.dispatch(basicInfoGetMiddleware()),
        store.dispatch(galleryImageMiddleware()),
        store.dispatch(educationGetMiddleware()),
        store.dispatch(careerGetMiddleware()),
        store.dispatch(presentAddressGetMiddleware()),
        store.dispatch(contactGetMiddleware()),
        store.dispatch(happyStoryCheckMiddleware()),
        store.dispatch(familyGetMiddleware()),
        store.dispatch(permanentAddressGetMiddleware()),
        store.dispatch(lifeStyleGetMiddleware()),
        store.dispatch(spiritualSocialGetMiddleware()),
        store.dispatch(residencyGetMiddleware()),
        store.dispatch(attitudeInterestsGetMiddleware()),
        store.dispatch(hobbiesInterestGetMiddleware()),
        store.dispatch(languageGetMiddleware()),
        store.dispatch(physicalAttributesGetMiddleware()),
        store.dispatch(astronomicGetMiddleware()),
        store.dispatch(partnerExpectationGetMiddleware()),
      ],
      builder: (_, state) => DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              buildGradientLayout(context, state),
              Expanded(
                child: TabBarView(children: [
                  buildListViewSeperated(),
                  buildPartnerPreference(context, state),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPartnerPreference(BuildContext context, AppState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10.0,
            right: Const.kPaddingHorizontal,
            left: Const.kPaddingHorizontal,
            bottom: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              build_general_requirement(context, state),
              build_min_height(context, state),
              build_max_weight(context, state),
              build_residence_marital_row(context, state),
              SizedBox(
                height: 20,
              ),
              build_children_religion_row(context, state),
              SizedBox(
                height: 20,
              ),
              build_caste_subcaste_row(context, state),
              SizedBox(
                height: 20,
              ),
              build_language_smoking_Row(context, state),
              SizedBox(
                height: 20,
              ),
              build_education(context, state),
              build_profession(context, state),
              build_drinking_acceptable(context, state),
              build_diet_body_Row(context, state),
              SizedBox(
                height: 20,
              ),
              build_personal_value(context, state),
              build_manglik_counry_Row(context, state),
              SizedBox(
                height: 20,
              ),
              build_state_family_value_Row(context, state),
              SizedBox(
                height: 20,
              ),
              build_complexion(context, state),
              InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (!_formKey.currentState.validate()) {
                    MyScaffoldMessenger()
                        .sf_messenger(text: "Form's not validated!");
                  } else {
                    store.dispatch(partnerExpectationMiddleware(
                        context: context,
                        general_info: store
                            .state
                            .manageProfileCombineState
                            .partnerExpectationState
                            .general_requirement_controller
                            .text,
                        min_height: store.state.manageProfileCombineState
                            .partnerExpectationState.min_height_controller.text,
                        max_weight: store.state.manageProfileCombineState
                            .partnerExpectationState.max_weight_controller.text,
                        residency_country: state.manageProfileCombineState
                            .partnerExpectationState.residency_country_val?.id,
                        marital_status: state.manageProfileCombineState
                            .partnerExpectationState.martial_status_val?.id,
                        children: state.manageProfileCombineState
                            .partnerExpectationState.children_value,
                        religion: state.manageProfileCombineState.partnerExpectationState.religion_val?.id,
                        caste: state.manageProfileCombineState.partnerExpectationState.caste_val?.id,
                        subcaste: state.manageProfileCombineState.partnerExpectationState.sub_caste_val?.id,
                        language: state.manageProfileCombineState.partnerExpectationState?.language_value?.id,
                        smoking: state.manageProfileCombineState.partnerExpectationState.smoking_value,
                        education: store.state.manageProfileCombineState.partnerExpectationState.education_controller.text,
                        profession: store.state.manageProfileCombineState.partnerExpectationState.profession_controller.text,
                        drinking: state.manageProfileCombineState.partnerExpectationState.drinking_value,
                        diet: state.manageProfileCombineState.partnerExpectationState.diet_value,
                        body_type: store.state.manageProfileCombineState.partnerExpectationState.body_controller.text,
                        personal_value: store.state.manageProfileCombineState.partnerExpectationState.personal_value_controller.text,
                        manglik: state.manageProfileCombineState.partnerExpectationState.manglik_val,
                        pref_country: state.manageProfileCombineState.partnerExpectationState.preferred_country?.id,
                        pref_state: state.manageProfileCombineState.partnerExpectationState.preferred_state?.id,
                        family_val: state.manageProfileCombineState.partnerExpectationState.family_value?.id,
                        complexion: store.state.manageProfileCombineState.partnerExpectationState.complexion_controller.text));
                  }
                },
                child: Container(
                  height: 45,
                  width: DeviceInfo(context).width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: [
                        MyTheme.gradient_color_1,
                        MyTheme.gradient_color_2,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  child: Center(
                    child: state
                                .manageProfileCombineState
                                .partnerExpectationState
                                .partner_expectation_save_changes ==
                            false
                        ? Text(
                            AppLocalizations.of(context).save_change_btn_text,
                            style: Styles.bold_white_14,
                          )
                        : CircularProgressIndicator(
                            color: MyTheme.storm_grey,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildGradientLayout(BuildContext context, AppState state) {
    return Container(
        height: 250,
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
            bottomRight: Radius.circular(32.0),
          ),
        ),
        child: SafeArea(
          child: Container(
            height: 220,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10),
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
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              child: MyImages.normalImage(
                                  state.accountState.profileData.memberPhoto),
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
                        '${_userAge} years, ${_userHeight} ft, ${_userMaritalStatus}',
                        style: Styles.regular_white_10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                      // physics: NeverScrollableScrollPhysics(),
                      unselectedLabelStyle:
                          TextStyle(color: MyTheme.light_grey),
                      onTap: (value) {
                        store.dispatch(UpdateTab(value));
                        //  store.state.manageProfileCombineState.selectedTabIndex =
                        //      value;
                      },
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: NavigationButton(
                            color: state.manageProfileCombineState
                                        .selectedTabIndex ==
                                    0
                                ? MyTheme.gull_grey.withOpacity(0.2)
                                : null,
                            text: 'Detailed profile',
                          ),
                        ),
                        Tab(
                          child: NavigationButton(
                            color: state.manageProfileCombineState
                                        .selectedTabIndex ==
                                    1
                                ? MyTheme.gull_grey.withOpacity(0.2)
                                : null,
                            text: 'Partner Preferences',
                          ),
                        ),
                        // Tab(
                        //     child: NavigationButton(
                        //   text: 'Gallery',
                        // )),
                      ]),
                  // horizontal line end
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildListViewSeperated() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal, left: Const.kPaddingHorizontal),
        child: ListView(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyProfileListData(
                    title: "About",
                    subtitle: 'on behalf selfs',
                    link: store.state.manageProfileCombineState
                                .introductionState.introductionGetResponse !=
                            null
                        ? const Introduction()
                        : null,
                    icon: 'assets/icon/icon_left_qoute.png',
                    pp: PP_Information(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .introductionState.introductionGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Basic Information",
                    link: BasicInformation(),
                    icon: 'assets/icon/icon_basicInfo.png',
                    pp: PP_BasicInformation(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .basicInfoState.basicInfoGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Location",
                    link: PresentAddress(),
                    icon: 'assets/icon/icon_presentAddress.png',
                    pp: PP_PresentAddress(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .presentAddressState.presentAddressGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Change Your Email",
                    link: ContactDetails(),
                    icon: 'assets/icon/icon_contactDetails.png',
                    pp: PP_UserContactDetails(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .contactState.contactGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Education Details",
                    link: EducationInfo(),
                    icon: 'assets/icon/icon_educationCareer.png',
                    pp: PP_EducationInfo(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .educationState.educationGetResponse)
                        .getEducationPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Career Details",
                    link: CareerInfo(),
                    icon: 'assets/icon/icon_educationCareer.png',
                    pp: PP_CareerInfo(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .careerState.careerGetResponse)
                        .getCareerPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Physical Attributes",
                    link: PhysicalAtrributes(),
                    icon: 'assets/icon/icon_physicalAttri.png',
                    pp: PP_PhysicalAttributes(),
                    percentage: PercentageCalculator(
                            data: store
                                .state
                                .manageProfileCombineState
                                .physicalAttrState
                                .physicalAttributesGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Language",
                    link: Language(),
                    icon: 'assets/icon/icon_language.png',
                    pp: PP_Language(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .languageState.languageGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Hobbies & Interest",
                    link: HobbiesInterest(),
                    icon: 'assets/icon/icon_hobbiesInterest.png',
                    pp: PP_HobbiesInterest(),
                    percentage: PercentageCalculator(
                            data: store
                                .state
                                .manageProfileCombineState
                                .hobbiesInterestState
                                .hobbiesInterestGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Personal Attitude & Behavior",
                    link: PersonalAttitude(),
                    icon: 'assets/icon/icon_personalAttitude.png',
                    pp: PP_PersonalAttitude(),
                    percentage: PercentageCalculator(
                            data: store
                                .state
                                .manageProfileCombineState
                                .attributeBehaviorState
                                .attitudeBehaviorGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Residency Information",
                    link: ResidencyInformation(),
                    icon: 'assets/icon/icon_residency.png',
                    pp: PP_ResidencyInfo(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .residencyState.residencyGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Spiritual & Social Background",
                    link: SpiritualSocial(),
                    icon: 'assets/icon/icon_spiritualSocial.png',
                    pp: PP_SpiritualSocial(),
                    percentage: PercentageCalculator(
                            data: store
                                .state
                                .manageProfileCombineState
                                .spiritualSocialState
                                .spiritualSocialGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Life Style",
                    link: LifeStyle(),
                    icon: 'assets/icon/icon_lifeStyle.png',
                    pp: PP_LifeStyle(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .lifeStyleState.lifeStyleGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Astronomic Information",
                    link: AstronomicInformation(),
                    icon: 'assets/icon/icon_astronomy.png',
                    pp: PP_AstronomicInfo(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .astronomicState.astronomicGetResponse)
                        .getPercentage())
                .getWidget(context),
            const SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Permanent Address",
                    link: PermanentAddress(),
                    icon: 'assets/icon/icon_permanentAddress.png',
                    pp: PP_PermanentAddress(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .permanentAddressState.permanentGetResponse)
                        .getPercentage())
                .getWidget(context),
            SizedBox(
              height: 20,
            ),
            MyProfileListData(
                    title: "Family Information",
                    link: FamilyInformation(),
                    icon: 'assets/icon/icon_family.png',
                    pp: PP_FamilyInfo(),
                    percentage: PercentageCalculator(
                            data: store.state.manageProfileCombineState
                                .familyState.familyGetResponse)
                        .getPercentage())
                .getWidget(context),
          ],
        ),
      ),
    );
  }

  Widget build_general_requirement(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //general requirements
        /// general requirements
        Text(
          AppLocalizations.of(context).manage_profile_general_req,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Field required";
            }
            return null;
          },
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.general_requirement_controller,
          decoration: InputStyle.inputDecoration_text_field(
              hint: "General Requirement"),
        ),
        const SizedBox(
          height: 20,
        ),

        //general requirrements ends
      ],
    );
  }

  Widget build_min_height(BuildContext contextl, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// min height
        Text(
          AppLocalizations.of(context).manage_profile_min_height,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.min_height_controller,
          decoration: InputStyle.inputDecoration_text_field(
              hint: "Min Height (In Feet)"),
        ),
        const SizedBox(
          height: 20,
        ),

        // min height ends
      ],
    );
  }

  Widget build_max_weight(BuildContext context, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// max weight
        Text(
          AppLocalizations.of(context).manage_profile_max_weight,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.max_weight_controller,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Max weight (IN kg)"),
        ),
        const SizedBox(
          height: 20,
        ),

        // max weight ends
      ],
    );
  }

  Widget build_residence_marital_row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).public_profile_residency_country,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyTheme.solitude),
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CommonWidget().buildDropdownButtonFormField(
                    store.state.manageProfileCombineState
                        .profiledropdownResponseData.data.countryList, (value) {
                  store.dispatch(
                      PexResidencyCountryAddValueAction(value: value));
                },
                    value: state.manageProfileCombineState
                        .partnerExpectationState.residency_country_val),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)
                  .advanced_search_screen_marital_status,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CommonWidget().buildDropdownButtonFormField(
                  store
                      .state
                      .manageProfileCombineState
                      .profiledropdownResponseData
                      .data
                      .maritialStatus, (value) {
                store.dispatch(PexMaritalStatusAddValueAction(value: value));
              },
                  value: state.manageProfileCombineState.partnerExpectationState
                      .martial_status_val),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_children_religion_row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).manage_profile_children_acceptable,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyTheme.solitude),
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField(
                    iconSize: 0.0,
                    decoration: InputStyle.inputDecoration_text_field(
                        suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    value: state.manageProfileCombineState
                        .partnerExpectationState.children_value,
                    items: state.manageProfileCombineState
                        .partnerExpectationState.commonYesNoList
                        .map<DropdownMenuItem<dynamic>>((e) {
                      return DropdownMenuItem<dynamic>(
                        value: e,
                        child: Text(
                          e,
                          style: Styles.regular_gull_grey_12
                              .copyWith(color: MyTheme.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (dynamic newValue) {
                      state.manageProfileCombineState.partnerExpectationState
                          .children_value = newValue;
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_religion,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CommonWidget().buildDropdownButtonFormField(
                store.state.manageProfileCombineState
                    .profiledropdownResponseData.data.religionList,
                (value) {
                  store.dispatch(PexReligionAddValueAction(value: value));

                  if (state.manageProfileCombineState.partnerExpectationState
                      .casteResponse.data.isNotEmpty) {
                    store.dispatch(PexEmptyCaste());
                  }
                  if (state.manageProfileCombineState.partnerExpectationState
                      .subcasteResponse.data.isNotEmpty) {
                    store.dispatch(PexEmptySubCaste());
                  }
                  store.dispatch(casteMiddleware(value.id,
                      state: AppStates.partnerPreference));
                },
                value: state.manageProfileCombineState.partnerExpectationState
                    .religion_val,
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_caste_subcaste_row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).manage_profile_caste,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                child: DropdownButtonFormField<DDown>(
                  isExpanded: true,
                  iconSize: 0.0,
                  value: state.manageProfileCombineState.partnerExpectationState
                      .caste_val,
                  decoration: InputStyle.inputDecoration_text_field(
                      hint: "Select one",
                      suffixIcon: const Icon(Icons.keyboard_arrow_down)),
                  items: state.manageProfileCombineState.partnerExpectationState
                      .casteResponse.data
                      .map<DropdownMenuItem<DDown>>((e) {
                    return DropdownMenuItem<DDown>(
                      value: e,
                      child: Text(
                        e.name,
                        style: Styles.regular_gull_grey_12
                            .copyWith(color: MyTheme.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (DDown newValue) {
                    store.dispatch(PexCasteAddValueAction(value: newValue));

                    if (state.manageProfileCombineState.spiritualSocialState
                        .subcasteResponse.data.isNotEmpty) {
                      store.dispatch(PexEmptySubCaste());
                    }

                    store.dispatch(subcasteMiddleware(newValue.id,
                        appStates: AppStates.partnerPreference));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_sub_caste,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: DropdownButtonFormField<DDown>(
                isExpanded: true,
                iconSize: 0.0,
                value: state.manageProfileCombineState.partnerExpectationState
                    .sub_caste_val,
                decoration: InputStyle.inputDecoration_text_field(
                    hint: "Select one",
                    suffixIcon: const Icon(Icons.keyboard_arrow_down)),
                items: state.manageProfileCombineState.partnerExpectationState
                    .subcasteResponse.data
                    .map<DropdownMenuItem<DDown>>((e) {
                  return DropdownMenuItem<DDown>(
                    value: e,
                    child: Text(
                      e.name,
                      style: Styles.regular_gull_grey_12
                          .copyWith(color: MyTheme.black),
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  store.dispatch(PexSubCasteAddValueAction(value: newValue));
                },
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_language_smoking_Row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).public_profile_Lang,
                style: Styles.bold_arsenic_12.copyWith(color: MyTheme.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyTheme.solitude),
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CommonWidget().buildDropdownButtonFormField(
                    state.manageProfileCombineState.profiledropdownResponseData
                        .data.languageList, (value) {
                  state.manageProfileCombineState.partnerExpectationState
                      .language_value = value;
                },
                    value: state.manageProfileCombineState
                        .partnerExpectationState.language_value),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_smoking_acceptable,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: DropdownButtonFormField(
                  iconSize: 0.0,
                  decoration: InputStyle.inputDecoration_text_field(
                      suffixIcon: Icon(Icons.keyboard_arrow_down)),
                  value: state.manageProfileCombineState.partnerExpectationState
                      .smoking_value,
                  items: state.manageProfileCombineState.partnerExpectationState
                      .commonYesNoList
                      .map<DropdownMenuItem<dynamic>>((e) {
                    return DropdownMenuItem<dynamic>(
                      value: e,
                      child: Text(
                        e,
                        style: Styles.regular_gull_grey_12
                            .copyWith(color: MyTheme.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      state.manageProfileCombineState.partnerExpectationState
                          .smoking_value = newValue;
                    });
                  }),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_education(BuildContext context, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// education
        Text(
          AppLocalizations.of(context).manage_profile_education,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.education_controller,
          decoration: InputStyle.inputDecoration_text_field(hint: "Education"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_profession(BuildContext context, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///profession
        Text(
          AppLocalizations.of(context).manage_profile_profession,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.profession_controller,
          decoration: InputStyle.inputDecoration_text_field(hint: "Profession"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_drinking_acceptable(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///drinking acceptable

        Text(
          AppLocalizations.of(context).manage_profile_drinking_acceptable,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          child: DropdownButtonFormField(
              iconSize: 0.0,
              decoration: InputStyle.inputDecoration_text_field(
                  suffixIcon: Icon(Icons.keyboard_arrow_down)),
              value: state.manageProfileCombineState.partnerExpectationState
                  .drinking_value,
              items: state.manageProfileCombineState.partnerExpectationState
                  .commonYesNoList
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                    style: Styles.regular_gull_grey_12
                        .copyWith(color: MyTheme.black),
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  state.manageProfileCombineState.partnerExpectationState
                      .drinking_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_diet_body_Row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).manage_profile_diet,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                child: DropdownButtonFormField(
                    iconSize: 0.0,
                    decoration: InputStyle.inputDecoration_text_field(
                        suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    value: state.manageProfileCombineState
                        .partnerExpectationState.diet_value,
                    items: state.manageProfileCombineState
                        .partnerExpectationState.commonYesNoList
                        .map<DropdownMenuItem<dynamic>>((e) {
                      return DropdownMenuItem<dynamic>(
                        value: e,
                        child: Text(
                          e,
                          style: Styles.regular_gull_grey_12
                              .copyWith(color: MyTheme.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        state.manageProfileCombineState.partnerExpectationState
                            .diet_value = newValue;
                      });
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_body_type,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: store.state.manageProfileCombineState
                  .partnerExpectationState.body_controller,
              decoration:
                  InputStyle.inputDecoration_text_field(hint: "Body Type"),
            )
          ],
        ))
      ],
    );
  }

  Widget build_personal_value(BuildContext context, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// personal value
        Text(
          AppLocalizations.of(context).manage_profile_personal_value,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.personal_value_controller,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Personal Value"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_manglik_counry_Row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).manage_profile_manglik,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                child: DropdownButtonFormField<dynamic>(
                  isExpanded: true,
                  iconSize: 0.0,
                  value: state.manageProfileCombineState.partnerExpectationState
                      .manglik_val,
                  decoration: InputStyle.inputDecoration_text_field(
                      hint: "Select one",
                      suffixIcon: const Icon(Icons.keyboard_arrow_down)),
                  items: state.manageProfileCombineState.partnerExpectationState
                      .commonYesNoList
                      .map<DropdownMenuItem<dynamic>>((e) {
                    return DropdownMenuItem<dynamic>(
                      value: e,
                      child: Text(
                        e,
                        style: Styles.regular_gull_grey_12
                            .copyWith(color: MyTheme.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    store.dispatch(PexManglikAddValueAction(value: newValue));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_preferred_country,
              style: Styles.bold_arsenic_12,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CommonWidget().buildDropdownButtonFormField(
                  store.state.manageProfileCombineState
                      .profiledropdownResponseData.data.countryList, (value) {
                // pref_country_value = value.id;
                store.dispatch(PexPreferredCountryAddValueAction(value: value));

                if (state.manageProfileCombineState.partnerExpectationState
                    .stateResponse.data.isNotEmpty) {
                  store.dispatch(PexEmptyPreferredState());
                }
                store.dispatch(stateMiddleware(value.id,
                    state: AppStates.partnerPreference));
              },
                  value: state.manageProfileCombineState.partnerExpectationState
                      .preferred_country),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_state_family_value_Row(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).manage_profile_preferred_state,
                style: Styles.bold_arsenic_12,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyTheme.solitude),
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<DDown>(
                  isExpanded: true,
                  iconSize: 0.0,
                  value: state.manageProfileCombineState.partnerExpectationState
                      .preferred_state,
                  decoration: InputStyle.inputDecoration_text_field(
                      hint: "Select one",
                      suffixIcon: const Icon(Icons.keyboard_arrow_down)),
                  items: state.manageProfileCombineState.partnerExpectationState
                      .stateResponse.data
                      .map<DropdownMenuItem<DDown>>((e) {
                    return DropdownMenuItem<DDown>(
                      value: e,
                      child: Text(
                        e.name,
                        style: Styles.regular_gull_grey_12
                            .copyWith(color: MyTheme.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    store.dispatch(
                        PexPreferredStateAddValueAction(value: newValue));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).manage_profile_family_value,
              style: Styles.bold_arsenic_12.copyWith(color: MyTheme.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.solitude),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CommonWidget().buildDropdownButtonFormField(
                  store
                      .state
                      .manageProfileCombineState
                      .profiledropdownResponseData
                      .data
                      .familyValueList, (value) {
                state.manageProfileCombineState.partnerExpectationState
                    .family_value = value;
              },
                  value: state.manageProfileCombineState.partnerExpectationState
                      .family_value),
            ),
          ],
        ))
      ],
    );
  }

  Widget build_complexion(BuildContext context, AppState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///complexion
        Text(
          AppLocalizations.of(context).manage_profile_complexion,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: store.state.manageProfileCombineState
              .partnerExpectationState.complexion_controller,
          decoration: InputStyle.inputDecoration_text_field(hint: "Complexion"),
        ),

        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
