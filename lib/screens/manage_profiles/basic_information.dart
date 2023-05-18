import 'dart:io';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/helpers/date_picker.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:active_matrimonial_flutter_app/models_response/drop_down/profile_dropdown_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/basic_info_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({Key key}) : super(key: key);

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final _formKey = GlobalKey<FormState>();


  static var dateOfBirth = store.state.manageProfileCombineState.basicInfoState
              .basicInfoGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.basicInfoState
          .basicInfoGetResponse.data.dateOfBirth
          .toString();



  static var photo = store.state.manageProfileCombineState.basicInfoState
      .basicInfoGetResponse.data.photo;



  // TextEditingController _genderController = TextEditingController(text: gender);
  TextEditingController _date_of_birthController =
      TextEditingController(text: dateOfBirth);




  TextEditingController _photo = TextEditingController();

  //for image uploading
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


  // var gendervalue = gender;

//global

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        !store.state.manageProfileCombineState.profiledropdownResponseData.result?store.dispatch(profiledropdownMiddleware()):null,
        store.state.manageProfileCombineState.basicInfoState.f_nameController.text = store.state.manageProfileCombineState.basicInfoState
            .basicInfoGetResponse.data.firsName,
        store.state.manageProfileCombineState.basicInfoState.l_nameController.text =store.state.manageProfileCombineState.basicInfoState
            .basicInfoGetResponse.data.lastName,
        store.state.manageProfileCombineState.basicInfoState.no_childController.text = store.state.manageProfileCombineState.basicInfoState
            .basicInfoGetResponse.data.noOfChildren
            .toString(),
                store.state.manageProfileCombineState.basicInfoState.phoneController.text = store.state.manageProfileCombineState.basicInfoState
            .basicInfoGetResponse.data.phone
            .toString(),


        //store.dispatch(profiledropdownMiddleware(appStates: AppStates.basicInfo)),
        store.state.manageProfileCombineState.basicInfoState.gendervalue =store.state.manageProfileCombineState.basicInfoState
        .basicInfoGetResponse.data.gender.toString()=="1"? "Male":"Female" ,

        // store.dispatch(basicInfoGetMiddleware())
      ],
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: build_body(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Const.kPaddingVertical,
          horizontal: Const.kPaddingHorizontal),
      color: Colors.white,
      width: DeviceInfo(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_f_name(context, state),
          build_l_name(context, state),
          build_gender(context, state),
          build_date_birth(context, state),
          build_phone(context, state),
          build_on_behalf(context, state),
          build_marital_status(context, state),
          build_no_children(context, state),
          build_photo(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {
                store.dispatch(basicInfoMiddleware(
                    context: context,
                    f_name: state.manageProfileCombineState.basicInfoState.f_nameController.text,
                    l_name: state.manageProfileCombineState.basicInfoState.l_nameController.text,
                    gender: state.manageProfileCombineState.basicInfoState.gendervalue=="male"?1:2,
                    dob: _date_of_birthController.text,
                    phone: state.manageProfileCombineState.basicInfoState.phoneController.text,
                    onbehalf: state.manageProfileCombineState.basicInfoState.on_behalves_value?.id,
                    m_status: state.manageProfileCombineState.basicInfoState.marital_status_value?.id,
                    noofChild: state.manageProfileCombineState.basicInfoState.no_childController.text,
                    photo: _image));
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
                borderRadius:const
                BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
              child: Center(
                child:
                    state.manageProfileCombineState.basicInfoState.isloading ==
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
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).introduction,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
        // f name
      ],
    );
  }

  Widget build_f_name(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_f_name,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.basicInfoState.f_nameController,
           hint: "Sara B.",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_l_name(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_l_name,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.basicInfoState.l_nameController,
          hint: "Dron",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_gender(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // gender and date of birth
        Text(
          AppLocalizations.of(context).manage_profile_gender,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
              decoration: InputDecoration(
                hintText: "Select One",
                isDense: true,
                hintStyle: Styles.regular_arsenic_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: MyTheme.gull_grey,
                ),
                // helperText: 'Helper text',
              ),
              value: state.manageProfileCombineState.basicInfoState.gendervalue,
              items: state.manageProfileCombineState.basicInfoState.gender_items.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                    style: Styles.regular_arsenic_14,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  state.manageProfileCombineState.basicInfoState.gendervalue = newValue;
                });
              }),
        ),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_date_birth(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // gender and date of birth
        Text(
          AppLocalizations.of(context).manage_profile_dob,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        DatePicker.date_picker(

            hint: "Select one", controller: _date_of_birthController),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_phone(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_phone_num,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.basicInfoState.phoneController,
          hint: "320-243-2537",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_on_behalf(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_onbehalf,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyTheme.solitude),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child:
                DropdownButtonFormField<DDown>(
              isExpanded: true,
              iconSize: 0.0,
              decoration: InputDecoration(
                hintText: "Select one",
                isDense: true,
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: MyTheme.gull_grey,
                ),
              ),
              value: state.manageProfileCombineState.basicInfoState.on_behalves_value,
              items: state.manageProfileCombineState.profiledropdownResponseData.data.onbehalfList
                  .map<DropdownMenuItem<DDown>>((e) {
                return DropdownMenuItem<DDown>(
                  value: e,
                  child: Text(
                    e.name,
                    style: Styles.regular_arsenic_14,
                  ),
                );
              }).toList(),
              onChanged: (DDown newValue) {
                  state.manageProfileCombineState.basicInfoState.on_behalves_value = newValue;


              },
            )),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_marital_status(BuildContext context, AppState state) {
    // var marital_status_items =
    //     .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // marital status and number of children
        Text(
          AppLocalizations.of(context).advanced_search_screen_marital_status,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<DDown>(
            isExpanded: true,
            iconSize: 0.0,
            decoration: InputDecoration(
              hintText: "Select one",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon:  Icon(
                Icons.keyboard_arrow_down,
                color:MyTheme.gull_grey,
              ),
            ),
            value: state.manageProfileCombineState.basicInfoState.marital_status_value,
            items: state.manageProfileCombineState
                .profiledropdownResponseData.data.maritialStatus.map<DropdownMenuItem<DDown>>((e) {
              return DropdownMenuItem<DDown>(
                value: e,
                child: Text(
                  e.name,
                  style: Styles.regular_arsenic_14,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              state.manageProfileCombineState.basicInfoState.marital_status_value = newValue;
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_no_children(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_number_of_child,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.basicInfoState.no_childController,
          hint: "No of children",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
        ),

        const SizedBox(
          height: 20,
        ),
        // f name
      ],
    );
  }

  Widget build_photo(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_photo,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            getImage();
          },
          child: Container(
            child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
              TextFormField(
                
                controller: _photo,
                readOnly: true,
                decoration: InputStyle.inputDecoration_text_field(
                    hint: _img_name != null ? _img_name : "Choose file"),
              ),
              Positioned(
                right: 5,
                child: SizedBox(
                  width: 100,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(MyTheme.white),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      child: Text('Browse', style: Styles.regular_storm_grey_12,)),
                ),
              )
            ]),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
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
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).manage_profile_basic_info,
        style: Styles.bold_arsenic_16,
      ),
    );
  }
}
