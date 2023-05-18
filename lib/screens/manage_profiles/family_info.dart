import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/family_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyInformation extends StatefulWidget {
  const FamilyInformation({Key key}) : super(key: key);

  @override
  State<FamilyInformation> createState() => _FamilyInformationState();
}

class _FamilyInformationState extends State<FamilyInformation> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fatherController = TextEditingController(
      text: store.state.manageProfileCombineState.familyState.familyGetResponse.result == false?"":
      store.state.manageProfileCombineState.familyState.familyGetResponse.data.father);
  TextEditingController _motherContrller = TextEditingController(
      text: store.state.manageProfileCombineState.familyState.familyGetResponse.result ==false? "":
      store.state.manageProfileCombineState.familyState.familyGetResponse.data.mother);

  TextEditingController _siblingContrller = TextEditingController(
      text: store.state.manageProfileCombineState.familyState.familyGetResponse.result==false? "":
      store.state.manageProfileCombineState.familyState.familyGetResponse.data.sibling);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      // onInit: (store) => store.dispatch(familyGetMiddleware()),
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal, vertical: 11),
              child: Form(key: _formKey, child: build_body(context, state)),
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
      title: Text(
        AppLocalizations.of(context).manage_profile_family_info,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Container(
      child:

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(context),
          buildFather(context, state),
          buildMother(context, state),
          buildSibling(context, state),
          InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (!_formKey.currentState.validate()) {
                      MyScaffoldMessenger()
                          .sf_messenger(text: "Form's not validated!");
                    } else {

                      store.dispatch(familyUpdateMiddleware(
                          context: context,
                          father: _fatherController.text,
                          mother: _motherContrller.text,
                          sibling: _siblingContrller.text));
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
                      child:state.manageProfileCombineState.familyState.pageloader == false
                          ?   Text(
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
              ,
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          AppLocalizations.of(context).manage_profile_your_family_info,
          style: Styles.bold_app_accent_14,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget buildFather(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_father + " *",
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _fatherController,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(hint: "Father"),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildMother(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_mother + " *",
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _motherContrller,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(hint: "Mother"),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget buildSibling(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_sibling + " *",
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          controller: _siblingContrller,
          decoration: InputStyle.inputDecoration_text_field(hint: "Siblings"),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
