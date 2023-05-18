import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/attitude_behavior_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/attitude_interest_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalAttitude extends StatefulWidget {
  const PersonalAttitude({Key key}) : super(key: key);

  @override
  State<PersonalAttitude> createState() => _PersonalAttitudeState();
}

class _PersonalAttitudeState extends State<PersonalAttitude> {
  final _formKey = GlobalKey<FormState>();

  static var affection = store.state.manageProfileCombineState
              .attributeBehaviorState.attitudeBehaviorGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.attributeBehaviorState
          .attitudeBehaviorGetResponse.data.affection;

  static var humor = store.state.manageProfileCombineState
              .attributeBehaviorState.attitudeBehaviorGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.attributeBehaviorState
          .attitudeBehaviorGetResponse.data.humor;

  static var religious = store.state.manageProfileCombineState
              .attributeBehaviorState.attitudeBehaviorGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.attributeBehaviorState
          .attitudeBehaviorGetResponse.data.religiousService;

  static var political_views = store.state.manageProfileCombineState
              .attributeBehaviorState.attitudeBehaviorGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.attributeBehaviorState
          .attitudeBehaviorGetResponse.data.politicalViews;

  TextEditingController _affection = TextEditingController(text: affection);
  TextEditingController _humor = TextEditingController(text: humor);
  TextEditingController _religious_service =
      TextEditingController(text: religious);
  TextEditingController _political_views =
      TextEditingController(text: political_views);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal, vertical: 11),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        build_body(context, state),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: buildAppBarContainer(context),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)
              .public_profile_your_personal_attri_behavior,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  build_affection(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).public_profile_affection,
          hint: "Tender Attachement",
          style: Styles.bold_arsenic_12,
          controller: _affection,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_humor(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).public_profile_humor,
          hint: "Incongruity, Slapstick",
          style: Styles.bold_arsenic_12,
          controller: _humor,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_religious_services(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).public_profile_religious_service,
          hint: "Interested",
          style: Styles.bold_arsenic_12,
          controller: _religious_service,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_political_views(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text:           AppLocalizations.of(context).public_profile_political_view,
          hint: "Not Interested",
          style: Styles.bold_arsenic_12,
          controller: _political_views,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_affection(context, state),
          build_humor(context, state),
          build_religious_services(context, state),
          build_political_views(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {
                store.dispatch(attitudeBehaviorUpdateMiddleware(
                    context: context,
                    affection: _affection.text,
                    humor: _humor.text,
                    religious_service: _religious_service.text,
                    political_views: _political_views.text));
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
                child: state.manageProfileCombineState.attributeBehaviorState
                            .isLoading ==
                        false
                    ? Text(
                        AppLocalizations.of(context).save_change_btn_text,
                        style: Styles.bold_white_14,
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBarContainer(BuildContext context) {
    return Text(
      AppLocalizations.of(context).public_profile_personal_attri_behavior,
      style: Styles.bold_arsenic_16,
    );
  }
}
