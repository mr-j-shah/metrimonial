import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/life_style_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/life_style_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LifeStyle extends StatefulWidget {
  const LifeStyle({Key key}) : super(key: key);

  @override
  State<LifeStyle> createState() => _LifeStyleState();
}

class _LifeStyleState extends State<LifeStyle> {
  final _formKey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) {
        if(store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.result !=null &&store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.result){
          store.state.manageProfileCombineState.lifeStyleState.living_withController.text=  store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.data.livingWith;

          store.state.manageProfileCombineState.lifeStyleState.diet_value=store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.data.diet;
          store.state.manageProfileCombineState.lifeStyleState.drink_value=store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.data.drink;
          store.state.manageProfileCombineState.lifeStyleState.smoke_value=store.state.manageProfileCombineState.lifeStyleState.lifeStyleGetResponse.data.smoke;
        }

      },
      builder: (_, state) =>
          state.manageProfileCombineState.lifeStyleState.isLoading == false
              ? Scaffold(
                  appBar: buildAppBar(context),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Const.kPaddingHorizontal, vertical: 11),
                      child: SingleChildScrollView(
                        child: Form(
                            key: _formKey, child: build_body(context, state)),
                      ),
                    ),
                  ),
                )
              :  Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.storm_grey,
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
      title: Text(
        AppLocalizations.of(context).public_profile_life_style,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).public_profile_your_life_style,
          style: Styles.bold_app_accent_14,
        ),
       const  SizedBox(
          height: 25,
        ),
      ],
    );
  }

  build_diet(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_diet,
          style: Styles.bold_arsenic_12,
        ),
        const  SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyTheme.solitude
          ),
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
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon:  Icon(
                  Icons.keyboard_arrow_down,
                  color:MyTheme.gull_grey,
                ),
                // helperText: 'Helper text',
              ),
              value: store.state.manageProfileCombineState.lifeStyleState.diet_value,
              items: store.state.manageProfileCombineState.lifeStyleState.items.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState.lifeStyleState.diet_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_drink(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_drink,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyTheme.solitude
          ),
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
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon:  Icon(
                  Icons.keyboard_arrow_down,
                  color:MyTheme.gull_grey,
                ),
                // helperText: 'Helper text',
              ),
              value: store.state.manageProfileCombineState.lifeStyleState.drink_value,
              items: store.state.manageProfileCombineState.lifeStyleState.items.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState.lifeStyleState.drink_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_smoke(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_smoke,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyTheme.solitude
          ),
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
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon:  Icon(
                  Icons.keyboard_arrow_down,
                  color:MyTheme.gull_grey,
                ),
                // helperText: 'Helper text',
              ),
              value: store.state.manageProfileCombineState.lifeStyleState.smoke_value,
              items: store.state.manageProfileCombineState.lifeStyleState.items.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  store.state.manageProfileCombineState.lifeStyleState.smoke_value = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_living_with(BuildContext context, AppState state) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_living_with,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: state.manageProfileCombineState.lifeStyleState.living_withController,
          decoration: InputStyle.inputDecoration_text_field(hint: "Parents"),
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
          build_diet(context, state),
          build_drink(context, state),
          build_smoke(context, state),
          build_living_with(context, state),
           InkWell(
                  onTap: () {
                    if (!_formKey.currentState.validate()) {
                      MyScaffoldMessenger()
                          .sf_messenger(text: "Form's not validated!");
                    } else {
                      store.state.manageProfileCombineState.lifeStyleState.diet_value == "yes" ? 1 : 2;
                      store.state.manageProfileCombineState.lifeStyleState.drink_value == "yes" ? 1 : 2;
                      store.state.manageProfileCombineState.lifeStyleState.smoke_value == "yes" ? 1 : 2;

                      store.dispatch(life_style_Middleware(
                          context: context,
                          diet: store.state.manageProfileCombineState.lifeStyleState.diet_value,
                          drink: store.state.manageProfileCombineState.lifeStyleState.drink_value,
                          smoke: store.state.manageProfileCombineState.lifeStyleState.smoke_value,
                          living_with: state.manageProfileCombineState.lifeStyleState.living_withController.text));
                    }
                  },
                  child:
                  Container(
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
                      child: state.manageProfileCombineState.lifeStyleState.saveChanges == false
                          ? Text(
                        AppLocalizations.of(context).save_change_btn_text,
                        style: Styles.bold_white_14,
                      )
                          :  Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.storm_grey,
                        ),
                      ),
                    ),
                  ),)

        ],
      ),
    );
  }
}
