import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/contact_update_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final _formKey = GlobalKey<FormState>();

  static var email = store.state.manageProfileCombineState.contactState
              .contactGetResponse.result ==
          false
      ? ""
      : store.state.manageProfileCombineState.contactState.contactGetResponse
          .data.email;

  TextEditingController _emailController = TextEditingController(text: email);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
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
        AppLocalizations.of(context).public_profile_contact_details,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_your_contact_details,
          style: Styles.bold_app_accent_14,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  build_email(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).manage_profile_your_email_id,
          style: Styles.bold_arsenic_12,
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Required Field";
            }
            // using regular expression
            if (!RegExp(r'\S+@\S+\.com').hasMatch(val)) {
              return "Please enter a valid email address";
            }
            return null;
          },
          controller: _emailController,
          decoration:
              InputStyle.inputDecoration_text_field(hint: "Email address"),
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
          build_email(context, state),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState.validate()) {
                MyScaffoldMessenger()
                    .sf_messenger(text: "Form's not validated!");
              } else {
                store.dispatch(contactMiddleware(
                    context: context, email: _emailController.text));
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
                child:
                    state.manageProfileCombineState.contactState.cdsave == false
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
}
