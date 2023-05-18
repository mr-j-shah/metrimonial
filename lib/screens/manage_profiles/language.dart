import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/custom/toast_component.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/lanugage_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:toast/toast.dart';

import '../../helpers/device_info.dart';

class Language extends StatefulWidget {
  const Language({Key key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        !store.state.manageProfileCombineState.profiledropdownResponseData.result?store.dispatch(profiledropdownMiddleware()):null,
        store.state.manageProfileCombineState.languageState.saveChangesLoader = false,
        if(store.state.manageProfileCombineState.languageState.languageGetResponse.result != null && store.state.manageProfileCombineState.languageState.languageGetResponse.result)
          {
            store.state.manageProfileCombineState.languageState
                .selectedKnowLanguage.clear(),
            store.state.manageProfileCombineState.profiledropdownResponseData.data
                .languageList
                .forEach((element) {
                  if(element.id == store.state.manageProfileCombineState.languageState.languageGetResponse.data.motherTongue?.id){
                    store.state.manageProfileCombineState.languageState.selectedMotherTongue=element;

                  }
                  var isContainKnownLanguage =store.state.manageProfileCombineState.languageState.languageGetResponse.data.knownLanguages.where((knowLanguages) => knowLanguages.id==element.id);
                  if(isContainKnownLanguage.isNotEmpty) {
                    store.state.manageProfileCombineState.languageState
                        .selectedKnowLanguage.add(element.id);
                  }
            }),



          }
        // print(store.state.manageProfileCombineState.profiledropdownResponseData==null),
      ],
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal, vertical: 11),
            child: Form(key: _formKey, child: build_body(context, state)),
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
        constraints: const BoxConstraints(),
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
        AppLocalizations.of(context).public_profile_Lang,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  Widget build_mother_tongue(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).search_screen_mother_tongue,
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
          child: CommonWidget().buildDropdownButtonFormField(
              state.manageProfileCombineState.profiledropdownResponseData.data.languageList, (value) {
            state.manageProfileCombineState.languageState.selectedMotherTongue = value;
          },
            value: state.manageProfileCombineState.languageState.selectedMotherTongue
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_known_language(BuildContext context, AppState state) {
    print(state.manageProfileCombineState.languageState.selectedKnowLanguage.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).public_profile_known_language,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 5,
        ),
        MultiSelectFormField(
          enabled: true,
          fillColor: MyTheme.solitude,
          dialogShapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          title: const Text(''),
          dataSource: state.manageProfileCombineState.profiledropdownResponseData.data.languageList.map((e) => {"name": e.name, "id": e.id})
              .toList(),
          textField: 'name',
          valueField: 'id',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          hintWidget: const Text('Please choose one or more'),
          initialValue:state.manageProfileCombineState.languageState.selectedKnowLanguage,
          onSaved: ( value) {
            if (value == null) return;
            state.manageProfileCombineState.languageState.selectedKnowLanguage.clear();
           state.manageProfileCombineState.languageState.selectedKnowLanguage.addAll(value);
            // print(selected);
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  build_body(BuildContext context, AppState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).public_profile_your_lang,
            style: Styles.bold_app_accent_14,
          ),
          const SizedBox(
            height: 25,
          ),
          build_mother_tongue(context, state),
          build_known_language(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else if(!state.manageProfileCombineState.languageState
                  .saveChangesLoader){
                store.dispatch(languageUpdateMiddleware(
                    context: context,
                    mother_tongue: state.manageProfileCombineState.languageState.selectedMotherTongue?.id,
                    known_language: state.manageProfileCombineState.languageState.selectedKnowLanguage));
              }else{
                ToastComponent.showDialog(context, "Please Wait...",gravity: Toast.center,bgColor: MyTheme.white);

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
              child: state.manageProfileCombineState.languageState
                          .saveChangesLoader
                  ? Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      ),
                    )
                  : Center(
                      child: Text(
                        AppLocalizations.of(context).save_change_btn_text,
                        style: Styles.bold_white_14,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

}
