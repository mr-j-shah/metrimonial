import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_gradient_container.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/social_logins.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/forget_password.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isGoogle = store.state.featureState.feature?.googleLogin == null
      ? false
      : store.state.featureState.feature?.googleLogin;
  bool isFacebook = store.state.featureState.feature?.facebookLogin == null
      ? false
      : store.state.featureState.feature?.facebookLogin;
  bool isTwitter = store.state.featureState.feature?.twitterLogin == null
      ? false
      : store.state.featureState.feature?.twitterLogin;

  //
  bool isOtpSystem = store.state.addonState.data?.otpSystem == null
      ? false
      : store.state.addonState.data?.otpSystem;

  @override
  void initState() {
    prefs.setBool(Const.isViewed, true);
    store.dispatch(featureCheckMiddleware());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => SizedBox(
            height: DeviceInfo(context).height,
            child: buildStack(context, state)),
      ),
    );
  }

  Stack buildStack(BuildContext context, AppState state) {
    return Stack(
      children: [
        buildGradientContainer(context),
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                Container(
                  width: DeviceInfo(context).width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      // key form
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.signInState.isPhoneOrEmail
                                ? "Phone"
                                : "Email",
                            style: Styles.bold_app_accent_12,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          state.signInState.isPhoneOrEmail
                              ? phone_field()
                              : email_field(),

                          const SizedBox(
                            height: 5,
                          ),
                          email_or_phone(context, state),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of(context).common_password_text,
                            style: Styles.bold_app_accent_12,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          password_field(state),
                          const SizedBox(
                            height: 5,
                          ),
                          // forget password
                          forget_password(context),
                          const SizedBox(
                            height: 40,
                          ),
                          login_button(context, state),

                          const SizedBox(
                            height: 40,
                          ),

                          /// sign in if not have account to login
                          others(context, state),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget others(BuildContext context, AppState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).login_screen_if_have_account,
              style: Styles.regular_gull_grey_12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
              child: Text(
                ' ' + AppLocalizations.of(context).login_screen_signup,
                style: Styles.bold_app_accent_12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        if (isGoogle || isFacebook || isTwitter)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).login_screen_or_signup,
                style: Styles.regular_gull_grey_12,
              ),
            ],
          ),
        const SizedBox(
          height: 20,
        ),

        /// social button google facebook twitter
        buildSocialLoginContainer(context, state)
      ],
    );
  }

  Widget login_button(BuildContext context, AppState state) {
    return InkWell(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!_formKey.currentState.validate()) {
          MyScaffoldMessenger().sf_messenger(text: "Form's not validated!");
        } else {
          store.dispatch(signInMiddleware(
              email: state.signInState.isPhoneOrEmail
                  ? state.signInState.phoneNumber
                  : _email.text,
              password: _password.text));
        }
      },
      child: MyGradientContainer(
        text: state.signInState.isLogin == false
            ? Text(
                AppLocalizations.of(context).login_button_text,
                style: Styles.bold_white_14,
              )
            : CircularProgressIndicator(
                color: MyTheme.storm_grey,
              ),
      ),
    );
  }

  Widget forget_password(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgetPassword()),
        );
      },
      child: SizedBox(
        width: DeviceInfo(context).width,
        child: Text(
          AppLocalizations.of(context).login_screen_forget_password,
          style: Styles.italic_app_accent_10_underline,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  TextFormField password_field(AppState state) {
    return TextFormField(
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
      obscureText: state.signInState.isObscure,
      decoration: InputStyle.inputDecoratio_password(
          hint: ". . . . . . . .",
          suffixIcon: GestureDetector(
              onTap: () {
                store.dispatch(IsObscureAction());
              },
              child: Icon(state.signInState.isObscure
                  ? Icons.visibility_off
                  : Icons.visibility))),
    );
  }

  Widget email_or_phone(BuildContext context, AppState state) {
    return InkWell(
      onTap: () {
        store.dispatch(IsPhoneOrEmailChangeAction());
      },
      child: SizedBox(
        width: DeviceInfo(context).width,
        child: Text(
          state.signInState.isPhoneOrEmail
              ? AppLocalizations.of(context).common_screen_use_email
              : isOtpSystem
                  ? AppLocalizations.of(context).common_screen_use_phone
                  : '',
          textAlign: TextAlign.right,
          style: Styles.italic_app_accent_10_underline,
        ),
      ),
    );
  }

  Widget email_field() {
    return TextFormField(
      controller: _email,
      validator: (value) {
        // Check if this field is empty
        if (value == null || value.isEmpty) {
          return 'Please enter email address';
        }

        // using regular expression
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please enter a valid email address";
        }

        // the email is valid
        return null;
      },
      decoration: InputStyle.inputDecoration_text_field(
        hint: "johndoe@example.com",
      ),
    );
  }

  Widget phone_field() {
    return SizedBox(
      child: isOtpSystem
          ? InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                store.dispatch(
                    SetPhoneNumberAction(payload: number.phoneNumber));
              },
              spaceBetweenSelectorAndTextField: 0,
              // textFieldController: _email,
              selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG),
              // inputBorder: InputBorder.none,
              inputDecoration: InputDecoration(
                filled: true,
                fillColor: MyTheme.solitude,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.transparent)),

                isDense: true,
                hintText: "01XXX XXX XXX",
                hintStyle: Styles.regular_gull_grey_12,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                // helperText: 'Helper text',
              ),
            )
          : SizedBox(),
    );
  }

  Widget buildSocialLoginContainer(BuildContext context, AppState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isFacebook,
          child: CommonWidget.social_button(
              icon: "icon_facebook.png",
              width: 42,
              height: 42,
              radius: 20,
              color: MyTheme.solitude,
              onpressed: () {
                SocialLogins().onPressedFacebookLogin(context);
              }
              // opacity: 0.1,
              ),
        ),
        SizedBox(
          width: DeviceInfo(context).width * 0.05,
        ),
        Visibility(
          visible: isGoogle,
          child: CommonWidget.social_button(
              icon: "icon_google.png",
              width: 42,
              height: 42,
              radius: 20,
              color: MyTheme.solitude,
              // opacity: 0.1,
              onpressed: () {
                SocialLogins().onPressedGoogleLogin(context);
              }),
        ),
        SizedBox(
          width: DeviceInfo(context).width * 0.05,
        ),
        Visibility(
          visible: isTwitter,
          child: CommonWidget.social_button(
              icon: "icon_twitter.png",
              width: 42,
              height: 42,
              radius: 20,
              color: MyTheme.solitude,
              // opacity: 0.1,
              onpressed: () {
                SocialLogins().onPressedTwitterLogin(context);
              }),
        ),
      ],
    );
  }

  Widget buildGradientContainer(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height * 0.50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        children: [
          const SizedBox(
            height: 78,
          ),
          const ImageIcon(
            AssetImage('assets/logo/app_logo.png'),
            size: 93,
            color: MyTheme.white,
          ),
          Text(
            AppLocalizations.of(context).login_text_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context).login_text_sub_title,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }
}
