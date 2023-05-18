import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/city_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/state_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/permanent_address_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/permanent_address_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PermanentAddress extends StatefulWidget {
  const PermanentAddress({Key key}) : super(key: key);

  @override
  State<PermanentAddress> createState() => _PermanentAddressState();
}

class _PermanentAddressState extends State<PermanentAddress> {
  final _formKey = GlobalKey<FormState>();

  // static var postal = store.state.manageProfileCombineState
  //             .permanentAddressState.permanentGetResponse.result ==
  //         false
  //     ? ""
  //     : store.state.manageProfileCombineState.permanentAddressState
  //         .permanentGetResponse.data.postalCode;
  //
  // TextEditingController _postalcodecontroller =
  //     TextEditingController(text: postal);
  //
  // var country_value;
  // var cid;
  // var inpt_country;
  // var s_value;
  // var c_value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //store.dispatch(PEmptyStateValueAction());
   // store.dispatch(PEmptyCityValueAction());
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, AppState>(
      onInit: (store){
        if (store.state.manageProfileCombineState.permanentAddressState
            .permanentGetResponse.result && store.state.manageProfileCombineState.profiledropdownResponseData.data.countryList.isNotEmpty
        ) {
          //store.state.manageProfileCombineState.permanentAddressState.selected_country= store.state.manageProfileCombineState.profiledropdownResponseData.countryList.first;
          store.state.manageProfileCombineState.profiledropdownResponseData.data.countryList
              .forEach((element) {
            if (element.name ==
                store.state.manageProfileCombineState.permanentAddressState
                    .permanentGetResponse.data.country) {
              store.state.manageProfileCombineState.permanentAddressState.selected_country = element;
            }
          });
          store.dispatch(stateMiddleware(store.state.manageProfileCombineState.permanentAddressState.selected_country.id,state: AppStates.permanentAddress));

          store.state.manageProfileCombineState.permanentAddressState.postalCodeController.text=store.state.manageProfileCombineState.permanentAddressState
              .permanentGetResponse.data.postalCode;
        }
      },
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: state.manageProfileCombineState.permanentAddressState
                      .is_loading ==
                  false
              ? SafeArea(
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
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
                  ),
                ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          build_title(context, state),
          build_country(context, state),
          build_state(context, state),
          build_city(context, state),
          build_postal_code(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {

                store.dispatch(permanentAddressUpdateMiddleware(
                    context: context,
                    country: state.manageProfileCombineState.permanentAddressState.selected_country.id,
                    state: state.manageProfileCombineState.permanentAddressState.selected_state.id,
                    city: state.manageProfileCombineState.permanentAddressState.selected_city?.id,
                    postal_code: state.manageProfileCombineState.permanentAddressState.postalCodeController.text));


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
                child: state.manageProfileCombineState.permanentAddressState
                            .permanent_address_save_changes ==
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
        AppLocalizations.of(context).manage_profile_permanent_address,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_your_permanent_address,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  build_country(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_country,
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
            child:
                DropdownButtonFormField<dynamic>(
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
              value: state.manageProfileCombineState.permanentAddressState.selected_country,
              items: state.manageProfileCombineState.profiledropdownResponseData.data.countryList
                  .map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e.name,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                state.manageProfileCombineState.permanentAddressState.selected_country =newValue;
                if (state.manageProfileCombineState.permanentAddressState
                    .stateResponse.data.isNotEmpty) {
                  store.dispatch(PEmptyStateValueAction());
                }
                if (state.manageProfileCombineState.permanentAddressState
                    .cityResponse.data.isNotEmpty) {
                  store.dispatch(PEmptyCityValueAction());
                }
                store.dispatch(stateMiddleware(newValue.id,state: AppStates.permanentAddress));
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_state(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_state,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
            iconSize: 0.0,

            decoration: InputDecoration(
              hintText: "Select One",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: MyTheme.gull_grey,
              ),
              // helperText: 'Helper text',
            ),
            value:
            state.manageProfileCombineState.permanentAddressState.selected_state,
            items: state.manageProfileCombineState.permanentAddressState
                .stateResponse.data
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e,
                child: Text(
                  e.name,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              state.manageProfileCombineState.permanentAddressState.selected_state =newValue;
              if (state.manageProfileCombineState.permanentAddressState
                  .cityResponse.data.isNotEmpty) {
                store.dispatch(PEmptyCityValueAction());
              }
              store.dispatch(cityMiddleware(state.manageProfileCombineState.permanentAddressState.selected_state.id, AppStates.permanentAddress));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_city(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_city,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: MyTheme.solitude),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
            iconSize: 0.0,
            value: state.manageProfileCombineState.permanentAddressState.selected_city,
            decoration: InputDecoration(
              hintText: "Select One",
              isDense: true,
              hintStyle: Styles.regular_gull_grey_12,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: MyTheme.gull_grey,
              ),
              // helperText: 'Helper text',
            ),
            items: state.manageProfileCombineState.permanentAddressState
                .cityResponse.data
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e,
                child: Text(
                  e.name,
                ),
              );
            }).toList(),

            onChanged: (dynamic newValue) {
              state.manageProfileCombineState.permanentAddressState.selected_city= newValue;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_postal_code(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_postal_code,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required field";
            }
            return null;
          },
          controller: state.manageProfileCombineState.permanentAddressState.postalCodeController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Postal Code"),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
