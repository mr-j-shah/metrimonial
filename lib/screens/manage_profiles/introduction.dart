import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/intro_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _textController = TextEditingController(
      text: store.state.manageProfileCombineState.introductionState
          .introductionGetResponse.data.introduction);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: state.manageProfileCombineState.introductionState.pageLoader ==
                  false
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Const.kPaddingHorizontal, vertical: 10),
                  child: Form(key: _formKey, child: build_body(context, state)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).public_profile_your_introduction,
          style: Styles.bold_app_accent_12,
        ),
        SizedBox(
          height: 25,
        ),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyTheme.solitude
          ),
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(minHeight: 150),
          child:TextFormField(
            controller: _textController,
            decoration: InputDecoration.collapsed(hintText: "Text..."),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

        ),

        SizedBox(
          height: 40,
        ),
        InkWell(
            onTap: () {
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {
                store.dispatch(IntroUpdateMiddleware(
                    context: context, text: _textController.text));
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
              child:
                  state.manageProfileCombineState.introductionState.isLoading ==
                          false
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context).save_change_btn_text,
                            style: Styles.bold_white_14,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: MyTheme.storm_grey,
                          ),
                        ),
            )),
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
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).introduction,
        style: Styles.bold_arsenic_16,
      ),
    );
  }
}
