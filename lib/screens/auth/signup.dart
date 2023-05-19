import 'dart:convert';

import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/social_logins.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signup_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/on_behalf/on_behalf_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:onfido_sdk/onfido_sdk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _refferController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  // value will change by use email instead or phone instead
  bool valueChanger = false;
  var phoneNumber;

  final _formKey = GlobalKey<FormState>();

  // visible/show or invisible/hide password
  bool _isObscure = true;

  // check box value
  bool check_box = false;

  var on_behalves_value;
  String _applicantId;
  String _sdktoken;
  // gender

  // var gendervalue;
  var gender_items = ['Male', 'Female'];
  var gendervalue = "Male";

  bool isGoogle = store.state.featureState.feature?.googleLogin == null
      ? false
      : store.state.featureState.feature?.googleLogin;
  bool isFacebook = store.state.featureState.feature?.facebookLogin == null
      ? false
      : store.state.featureState.feature?.facebookLogin;
  bool isTwitter = store.state.featureState.feature?.twitterLogin == null
      ? false
      : store.state.featureState.feature?.twitterLogin;

  bool isOtpSystem = store.state.addonState.data.otpSystem;
  bool isReferralSystem = store.state.addonState.data.referralSystem;

  var date = DateTime.now();

  // bool isOtpSystem = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) => [
          store.dispatch(onbehalfMiddleware()),
          store.dispatch(addonCheckMiddleware())
        ],
        builder: (_, state) => SizedBox(
            height: DeviceInfo(context).height,
            child: Stack(
              children: [
                buildGradeintLogo(context),
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 250,
                        ),
                        Container(
                          // height: DeviceInfo(context).height * 0.75,
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
                                  // on be half

                                  buildOnBeHalf(context, state),
                                  // first name
                                  buildFirstName(context),
                                  // last name

                                  buildLastName(context),

                                  /// gender
                                  buildGender(context),
                                  // data of birth
                                  buildDateOfBirth(context, state),
                                  // email or phone
                                  buildEmailPhone(context, state),
                                  // password
                                  buildPassword(context),
                                  // confirm password
                                  buildConfirmPassword(context),

                                  /// refer code

                                  isReferralSystem
                                      ? buildRefer(context, state)
                                      : SizedBox(),
                                  buildAgreeTerms(context),

                                  InkWell(
                                    onTap: () async {
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();

                                      _applicantId = await applicants(
                                          _firstNameController.text,
                                          _lastNameController.text);
                                      await prefs.setString('applicantid', _applicantId);
                                      _sdktoken = await getsdk(_applicantId);
                                      startOnfido(_sdktoken);
                                      if (check_box == false) {
                                        MyScaffoldMessenger().sf_messenger(
                                            text:
                                                'Agree to terms and condition!');
                                      } else if (!_formKey.currentState
                                          .validate()) {
                                        MyScaffoldMessenger().sf_messenger(
                                            text: 'Form is not validated!');
                                      } else {
                                        if (gendervalue == "Male") {
                                          _genderController.text = "1";
                                        } else {
                                          _genderController.text = "2";
                                        }

                                        // print(_firstNameController.text);
                                        // print(_lastNameController.text);
                                        // print(phoneNumber);
                                        // print(_emailController.text);
                                        // print(valueChanger
                                        //     ? phoneNumber
                                        //     : _emailController.text);
                                        // print(valueChanger
                                        //     ? "phone"
                                        //     : "email");
                                        // print(on_behalves_value);
                                        // print(_genderController.text);
                                        // print(_dobController.text);
                                        // print(_passwordController.text);
                                        // print(_refferController.text);
                                        // print(_confirmpasswordController
                                        //     .text);

                                        store.dispatch(signupMiddleware(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          emailOrPhone: valueChanger
                                              ? phoneNumber
                                              : _emailController.text,
                                          emailOrPhoneText:
                                              valueChanger ? "phone" : "email",
                                          onBehalf: on_behalves_value,
                                          gender: _genderController.text,
                                          dateOfBirth: _dobController.text,
                                          password: _passwordController.text,
                                          passwordConfirmation:
                                              _confirmpasswordController.text,
                                          referral: _refferController.text,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: DeviceInfo(context).width,
                                      decoration: BoxDecoration(
                                        gradient: Styles.buildLinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: state.signUpState.isLoading ==
                                              false
                                          ? Center(
                                              child: Text(
                                              AppLocalizations.of(context)
                                                  .signup_screen_button_text_signup,
                                              style: Styles.bold_white_14,
                                            ))
                                          : Center(
                                              child: CircularProgressIndicator(
                                                color: MyTheme.storm_grey,
                                              ),
                                            ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 40,
                                  ),
                                  buildSocialLogin(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // else
                //   Center(child: CircularProgressIndicator())
              ],
            )),
      ),
    );
  }

  Container buildSocialLogin(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).signup_screen_already_account,
                style: Styles.regular_gull_grey_12,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Text(
                  ' ' + AppLocalizations.of(context).signup_screen_login,
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
                  AppLocalizations.of(context).signup_screen_join_with,
                  style: Styles.regular_gull_grey_12,
                ),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
          ),
        ],
      ),
    );
  }

  Container buildGradeintLogo(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Styles.buildLinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
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
            AppLocalizations.of(context).signup_screen_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context).signup_screen_subtitle,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }

  buildOnBeHalf(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_onbehalf,
          style: Styles.bold_app_accent_12,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 49,
          child: DropdownButtonFormField<dynamic>(
            iconSize: 0.0,
            decoration: InputStyle.inputDecoration_text_field(
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            value: on_behalves_value,
            items: state.signUpState.onbehalfResponse.data
                .map<DropdownMenuItem<dynamic>>((e) {
              return DropdownMenuItem<dynamic>(
                value: e.id,
                child: Text(
                  e.name,
                  style: Styles.regular_gull_grey_12,
                ),
              );
            }).toList(),
            onChanged: (dynamic newValue) {
              setState(() {
                on_behalves_value = newValue;
              });

              // print(on_behalves_value.key);
              // print(on_behalves_value.value);
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildFirstName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_first_name,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter First Name';
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(
            hint: "John",
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildLastName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_last_name,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Last Name';
            }
            return null;
          },
          decoration: InputStyle.inputDecoration_text_field(
            hint: "Doe",
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_gender,
          style: Styles.bold_app_accent_12,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          child: DropdownButtonFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Required field";
                }
                return null;
              },
              iconSize: 0.0,
              decoration: InputStyle.inputDecoration_text_field(
                  suffixIcon: const Icon(Icons.keyboard_arrow_down)),
              value: gendervalue,
              items: gender_items.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(
                    e,
                    style: Styles.regular_gull_grey_12,
                  ),
                );
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  gendervalue = newValue;
                });
              }),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildDateOfBirth(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_dob,
          style: TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        Theme(
          data: ThemeData(
              primarySwatch:
                  MaterialColor(MyTheme.app_accent_color.value, <int, Color>{
            50: Color(0xFFFFEBEE),
            100: Color(0xFFFFCDD2),
            200: Color(0xFFEF9A9A),
            300: Color(0xFFE57373),
            400: Color(0xFFEF5350),
            500: Color(MyTheme.app_accent_color.value),
            600: Color(0xFFE53935),
            700: Color(0xFFD32F2F),
            800: Color(0xFFC62828),
            900: Color(0xFFB71C1C),
          })),
          child: DateTimePicker(
            controller: _dobController,
            decoration: InputStyle.inputDecoration_text_field(
                hint: "Select One",
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: MyTheme.app_accent_color,
                )),
            firstDate: DateTime(1970),
            initialDate: DateTime(2000),
            lastDate: (state.featureState.feature?.memberMinAge != "") &&
                    (state.featureState.feature?.memberMinAge != null)
                ? DateTime(
                    date.year -
                        int.parse(state.featureState.feature?.memberMinAge),
                    date.month,
                    date.day)
                : date,
            dateLabelText: 'Date',
            onChanged: (val) {
              return _dobController;
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter date';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  buildEmailPhone(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueChanger ? "Phone" : "Email",
          style: TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        valueChanger
            ? SizedBox(
                child: isOtpSystem
                    ? InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            // print(number.phoneNumber);
                            phoneNumber = number.phoneNumber;
                          });
                        },
                        spaceBetweenSelectorAndTextField: 0,

                        // textFieldController: _email,
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG),
                        // inputBorder: InputBorder.none,
                        inputDecoration: InputStyle.inputDecoration_text_field(
                          hint: "01XXX XXX XXX",
                        ),
                      )
                    : SizedBox(),
              )
            : TextFormField(
                controller: _emailController,
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
                  // suffixIcon: Icon(
                  //   Icons.expand_more,
                  // )
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            setState(() {
              valueChanger = !valueChanger;
            });
          },
          child: SizedBox(
            width: DeviceInfo(context).width,
            child: Text(
              valueChanger
                  ? AppLocalizations.of(context).common_screen_use_email
                  : isOtpSystem
                      ? AppLocalizations.of(context).common_screen_use_phone
                      : "",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 10,
                color: MyTheme.app_accent_color,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  buildPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).common_password_text,
          style: TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            }
            if (value.length <= 7) {
              return "Password should be 8 Charecters long";
            }
            return null;
          },
          obscureText: _isObscure,
          decoration: InputStyle.inputDecoratio_password(
            hint: ". . . . . . .",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: DeviceInfo(context).width,
          child: Text(
            AppLocalizations.of(context).common_screen_8_or_more_char,
            style: Styles.regular_gull_grey_10,
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buildConfirmPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).common_screen_confim_password,
          style: TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _confirmpasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Confirm Password';
            }
            if (_passwordController.text.toString() !=
                _confirmpasswordController.text.toString()) {
              return "Password don't match";
            }
            return null;
          },
          obscureText: _isObscure,
          decoration: InputStyle.inputDecoratio_password(
            hint: ". . . . . . .",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buildRefer(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).signup_screen_refer_code,
          style: TextStyle(
              color: MyTheme.app_accent_color,
              fontWeight: FontWeight.bold,
              fontSize: 11),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _refferController,
          decoration: InputStyle.inputDecoration_text_field(
            hint: "Type your refer code",
            // suffixIcon: Icon(Icons.remove_red_eye),
          ),
        ),
      ],
    );
  }

  buildAgreeTerms(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 21,
        ),
        Container(
          width: DeviceInfo(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  value: this.check_box,
                  activeColor: MyTheme.app_accent_color,
                  onChanged: (bool value) {
                    setState(() {
                      this.check_box = !this.check_box;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: DeviceInfo(context).width / 2,
                child: RichText(
                  text: TextSpan(
                    // style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .signup_screen_terms_part1,
                          style: Styles.regular_app_accent_12),
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .signup_screen_terms_part2,
                          style: Styles.bold_app_accent_12),
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .signup_screen_terms_part3,
                          style: Styles.regular_app_accent_12),
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .signup_screen_terms_part4,
                          style: Styles.bold_app_accent_12),
                    ],
                  ),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}

startOnfido(String sdktoken) async {
  try {
    final Onfido onfido = Onfido(sdkToken: sdktoken);
    final response = await onfido.start(
      flowSteps: FlowSteps(
        proofOfAddress: true,
        welcome: true,
        documentCapture: DocumentCapture(
            documentType: DocumentType.generic, countryCode: CountryCode.IND),
        faceCapture: FaceCaptureType.photo,
      ),
    );

    print("startOnfido response :: $response");

    onfido.startWorkflow("f65f6747-2961-43c7-a742-23e77b13f9a3");
  } catch (error) {
    print("startOnfido error :: $error");
  }
}

Future<String> applicants(String firstname, String lastname) async {
  print(firstname);
  print(lastname);
  final response = await http.post(
    Uri.parse('https://api.onfido.com/v3/applicants'),
    headers: {
      "Authorization":
          "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
      "Content-Type": "application/json"
    },
    body: jsonEncode(
      <String, dynamic>{"first_name": firstname, "last_name": lastname},
    ),
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201) {
    Map<String, dynamic> resposnsemap = jsonDecode(response.body);
    print(resposnsemap["id"]);
    return resposnsemap["id"];
  } else {
    return null;
  }
}

Future<String> getsdk(String applicant_id) async {
  final response = await http.post(
    Uri.parse('https://api.onfido.com/v3/sdk_token'),
    headers: {
      "Authorization":
          "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
      "Content-Type": "application/json"
    },
    body: jsonEncode(
      <String, dynamic>{
        "applicant_id": applicant_id,
        "application_id": "com.metromenial.app"
      },
    ),
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> resposnsemap = jsonDecode(response.body);
    print(resposnsemap["token"]);
    return resposnsemap["token"];
  } else {
    return null;
  }
}

Future<String> check(String applicant_id) async {
  final response = await http.post(
    Uri.parse('https://api.eu.onfido.com/v3.6/checks'),
    headers: {
      "Authorization":
          "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
      "Content-Type": "application/json"
    },
    body: jsonEncode(
      <String, dynamic>{
        "applicant_id": "6ce39d59-5ee5-4bbd-8038-9d3b964ceaa7",
        "report_names": ["document", "facial_similarity_photo"]
      },
    ),
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> resposnsemap = jsonDecode(response.body);
    print(resposnsemap["token"]);
    return resposnsemap["token"];
  } else {
    return null;
  }
}
