import 'package:active_matrimonial_flutter_app/custom/my_gradient_container.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_reducer.dart';
import 'package:flutter/material.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:active_matrimonial_flutter_app/screens/core.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    store.dispatch(RpReset());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: DeviceInfo(context).height,
          child: Stack(
            children: [
              // upper section of logo, login
              buildGredientPlusLogoContainer(context),
              Positioned(
                bottom: 0,
                child: Container(
                  height: DeviceInfo(context).height * 0.65,
                  width: DeviceInfo(context).width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      // key form
                      key: _formKey,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// password field
                          Text(
                            AppLocalizations.of(context).common_password_text,
                            style: Styles.bold_app_accent_12,
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          TextFormField(
                            obscureText:
                                state.resetPasswordState.passwordObscure,
                            controller: _password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length <= 7) {
                                return "Password should be 8 Characters long";
                              }
                              return null;
                            },
                            decoration: InputStyle.inputDecoratio_password(
                                hint: ". . . . . . .",
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      store.dispatch(
                                          ResetPasswordActions.passwordObscure);
                                    },
                                    icon: Icon(
                                        state.resetPasswordState.passwordObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: DeviceInfo(context).width,
                            child: Text(
                              AppLocalizations.of(context)
                                  .common_screen_8_or_more_char,
                              style: Styles.regular_gull_grey_10,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .common_screen_confim_password,
                            style: Styles.bold_app_accent_12,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          TextFormField(
                            obscureText:
                                state.resetPasswordState.confirmPasswordObscure,
                            controller: _confirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Confirm Password';
                              }
                              if (_password.text.toString() !=
                                  _confirmPassword.text.toString()) {
                                return "Password don't match";
                              }
                              return null;
                            },
                            decoration: InputStyle.inputDecoratio_password(
                              hint: ". . . . . . .",
                              suffixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    store.dispatch(ResetPasswordActions
                                        .confirmPasswordObscure);
                                  },
                                  icon: Icon(state.resetPasswordState
                                          .confirmPasswordObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                          ),

                          /// forget password

                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!_formKey.currentState.validate()) {
                                MyScaffoldMessenger().sf_messenger(
                                    text: "Form's not validated!");
                              } else {
                                store.dispatch(resetPasswordMiddleware(context,
                                    password: _password.text,
                                    confirm_password: _confirmPassword.text));

                              }
                            },
                            child: MyGradientContainer(
                              text: state.resetPasswordState.rp_loader == false
                                  ? Text(
                                      AppLocalizations.of(context)
                                          .common_confirm,
                                      style: Styles.bold_white_14,
                                    )
                                  : CircularProgressIndicator(
                                      color: MyTheme.storm_grey,
                                    ),
                            ),
                          ),
                        ],
                      ),
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

  Container buildGredientPlusLogoContainer(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height * 0.40,
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        children: [
          SizedBox(
            height: 78,
          ),
          ImageIcon(
            AssetImage('assets/logo/app_logo.png'),
            size: 93,
            color: MyTheme.white,
          ),
          Text(
            AppLocalizations.of(context).new_password_screen_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context).new_password_screen_subtitle,
            style:
                Styles.regular_white_14,
          ),
        ],
      ),
    );
  }
}
