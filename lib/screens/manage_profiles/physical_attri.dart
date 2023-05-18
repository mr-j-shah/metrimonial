import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/physical_attr_upate_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhysicalAtrributes extends StatefulWidget {
  const PhysicalAtrributes({Key key}) : super(key: key);

  @override
  State<PhysicalAtrributes> createState() => _PhysicalAtrributesState();
}

class _PhysicalAtrributesState extends State<PhysicalAtrributes> {
  final _formKey = GlobalKey<FormState>();

  static var height = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.height
          .toString();
  static var weight = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.weight
          .toString();
  static var eyecolor = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.eyeColor;
  static var haircolor = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.hairColor;
  static var complexion = store.state.manageProfileCombineState
              .physicalAttrState.physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.complexion;
  static var bodytype = store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.result == false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.bodyType;
  static var bodyart = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.bodyArt;
  static var disability = store.state.manageProfileCombineState
              .physicalAttrState.physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.disability;
  static var blood = store.state.manageProfileCombineState.physicalAttrState
              .physicalAttributesGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.physicalAttrState
          .physicalAttributesGetResponse.data.bloodGroup;

  TextEditingController _heightController = TextEditingController(text: height);
  TextEditingController _weightController = TextEditingController(text: weight);
  TextEditingController _eyeColorController =
      TextEditingController(text: eyecolor);
  TextEditingController _hairColorController =
      TextEditingController(text: haircolor);
  TextEditingController _complexionController =
      TextEditingController(text: complexion);
  TextEditingController _bodyTypeController =
      TextEditingController(text: bodytype);
  TextEditingController _bodyArtController =
      TextEditingController(text: bodyart);
  TextEditingController _disabilityController =
      TextEditingController(text: disability);
  TextEditingController _bloodController = TextEditingController(text: blood);


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _heightController.dispose();
    _weightController.dispose();
    _eyeColorController.dispose();
    _hairColorController.dispose();
    _complexionController.dispose();
    _bodyTypeController.dispose();
    _bodyArtController.dispose();
    _disabilityController.dispose();
    _bloodController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      // onInit: (store) => store.dispatch(physicalAttributesGetMiddleware()),
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal, vertical: 11),
            child: SingleChildScrollView(
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

  build_height(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_height,
          style: Styles.bold_arsenic_12,
          controller: _heightController,
          keyboard_type: TextInputType.number,
          hint: """5' 3""",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter height";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_weight(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_weight,
          style: Styles.bold_arsenic_12,
          keyboard_type: TextInputType.number,
          controller: _weightController,
          hint: "112.6 pounds (51.2 kilograms",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter weight";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_eye_color(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_eye_color,
          style: Styles.bold_arsenic_12,
          controller: _eyeColorController,
          hint: "Blue",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter eye color";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_hair_color(BuildContext context, AppState state) {
    // _hairColorController.text = state.manageProfileCombineState.physicalAttrState.physicalAttributesGetResponse.data.hairColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_hair_color,
          style: Styles.bold_arsenic_12,
          controller: _hairColorController,
          hint: "Black",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter hair color";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_complexion(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_complexion,
          style: Styles.bold_arsenic_12,
          controller: _complexionController,
          hint: "Olive skin",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter complexion";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_body_type(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_body_type,
          style: Styles.bold_arsenic_12,
          controller: _bodyTypeController,
          hint: "Medium",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body type";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_body_art(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_body_art,
          style: Styles.bold_arsenic_12,
          controller: _bodyArtController,
          hint: "Body piercing",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body art";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_disability(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_disability,
          style: Styles.bold_arsenic_12,
          controller: _disabilityController,
          hint: "No",
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_blood_group(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_blood_group,
          style: Styles.bold_arsenic_12,
          controller: _bloodController,
          hint: "B+",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter blood group";
            }
            if (value.length > 3) {
              return "Max 3 characters";
            }
            return null;
          },
        ),
        SizedBox(
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
          build_height(context, state),
          build_weight(context, state),
          build_eye_color(context, state),
          build_hair_color(context, state),
          build_complexion(context, state),
          build_body_type(context, state),
          build_body_art(context, state),
          build_disability(context, state),
          build_blood_group(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {
                store.dispatch(physicalAttrMiddleware(
                    context: context,
                    height: _heightController.text,
                    weight: _weightController.text,
                    eye_color: _eyeColorController.text,
                    hair_color: _hairColorController.text,
                    complexion: _complexionController.text,
                    body_type: _bodyTypeController.text,
                    body_art: _bodyArtController.text,
                    disability: _disabilityController.text,
                    blood_group: _bloodController.text));
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
                child: state.manageProfileCombineState.physicalAttrState
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
          ),
        ],
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
      title: Text(
        AppLocalizations.of(context).public_profile_physical_attri,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_physical_attri,
          style: Styles.bold_app_accent_14,
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
