// import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
// import 'package:active_matrimonial_flutter_app/const/const.dart';
// import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
// import 'package:active_matrimonial_flutter_app/const/style.dart';
// import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
// import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/get_manage_profile/caste_middleware.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/get_manage_profile/partnerExpectationGetMiddleware.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/get_manage_profile/state_middleware.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/get_manage_profile/sub_caste_middleware.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/partner_expectation_middleware.dart';
// import 'package:active_matrimonial_flutter_app/redux/middlewares/manage_profile_middleware/profile_dropdown_middleware.dart';
// import 'package:active_matrimonial_flutter_app/screens/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class PartnerExpectation extends StatefulWidget {
//   const PartnerExpectation({Key key}) : super(key: key);
//
/// this page content is moved from here to my partner expectation
//   @override
//   State<PartnerExpectation> createState() => _PartnerExpectationState();
// }
//
// class _PartnerExpectationState extends State<PartnerExpectation> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController _general_requirement_controller =
//       TextEditingController();
//   TextEditingController _min_height_controller = TextEditingController();
//   TextEditingController _max_weight_controller = TextEditingController();
//   TextEditingController _education_controller = TextEditingController();
//   TextEditingController _profession_controller = TextEditingController();
//   TextEditingController _body_controller = TextEditingController();
//   TextEditingController _personal_value_controller = TextEditingController();
//   TextEditingController _complexion_controller = TextEditingController();
//
//   var items = ['Yes', 'No', 'Does not matter'];
//
//   var children_value = 'Yes';
//
//   // residence status
//   var residency_country_value;
//
//   // marital status
//   var marital_status_value;
//
//   // children acceptable
//
//   // smoking
//   var smoking_value = 'No';
//
//   // drinking
//   var drinking_value = "Yes";
//
//   // manglik
//   var manglik_value;
//
//   // diet
//   var diet_value = "No";
//
//   // religion
//   var religion_value;
//
//   //caste
//   var caste_value;
//
//   //subcaste
//   var sub_caste_value;
//
//   //language
//   var language_value;
//
//   //pref country
//   var pref_country_value;
//
//   // pref state
//   var pref_state_value;
//
//   // family value
//   var family_value;
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AppState>(
//       converter: (store) => store.state,
//       onInit: (store) => [
//         store.dispatch(profiledropdownMiddleware()),
//         store.dispatch(partnerExpectationGetMiddleware())
//       ],
//       builder: (_, state) => Scaffold(
//         // appBar: buildAppBar(context),
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: Const.kPaddingHorizontal, vertical: 10),
//             child: SingleChildScrollView(
//               child: Form(key: _formKey, child: build_body(context, state)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget build_body(BuildContext context, AppState state) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           build_title(context, state),
//           build_general_requirement(context, state),
//           build_min_height(context, state),
//           build_max_weight(context, state),
//           build_residence_marital_row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_children_religion_row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_caste_subcaste_row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_language_smoking_Row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_education(context, state),
//           build_profession(context, state),
//           build_drinking_acceptable(context, state),
//           build_diet_body_Row(context, state),
//           build_personal_value(context, state),
//           build_manglik_counry_Row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_state_family_value_Row(context, state),
//           const SizedBox(
//             height: 20,
//           ),
//           build_complexion(context, state),
//           state.manageProfileCombineState.partnerExpectationState
//                       .partner_expectation_save_changes ==
//                   false
//               ? InkWell(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//
//                     if (!_formKey.currentState.validate()) {
//                       MyScaffoldMessenger(context)
//                           .sf_messenger(text: "Form's not validated!");
//                     } else {
//                       // print(
//                       //     " general requirement-----${_general_requirement_controller.text}");
//                       // print(" min height-------${_min_height_controller.text}");
//                       // print(" max weight-----${_max_weight_controller.text}");
//                       // print(" resi country---${residency_country_value}");
//                       // print(" martial status --${marital_status_value}");
//                       // print(" children ----${children_value}");
//                       // print("religious -----${religion_value}");
//                       // print("caste-------${caste_value}");
//                       // print("sub caste------ ${sub_caste_value}");
//                       // print("language------ ${language_value}");
//                       // print(" smoking -----${smoking_value}");
//                       // print(" education---${_education_controller.text}");
//                       // print("profession ------${_profession_controller.text}");
//                       // print("drinkng ------${drinking_value}");
//                       // print("body ------${_body_controller.text}");
//                       // print(
//                       //     "personal value-----${_personal_value_controller.text}");
//                       // print("manglik----- ${manglik_value}");
//                       // print(" pref country------ ${pref_country_value}");
//                       // print("pref state-----${pref_state_value}");
//                       // print("family value------${family_value}");
//                       // print(" complexion------${_complexion_controller.text}");
//
//                       store.dispatch(partnerExpectationMiddleware(
//                           context: context,
//                           general_info: _general_requirement_controller.text,
//                           min_height: _min_height_controller.text,
//                           max_weight: _max_weight_controller.text,
//                           residency_country: residency_country_value,
//                           marital_status: marital_status_value,
//                           children: children_value,
//                           religion: religion_value,
//                           caste: caste_value,
//                           subcaste: sub_caste_value,
//                           language: language_value,
//                           smoking: smoking_value,
//                           education: _education_controller.text,
//                           profession: _profession_controller.text,
//                           drinking: drinking_value,
//                           body_type: _body_controller.text,
//                           personal_value: _personal_value_controller.text,
//                           manglik: manglik_value,
//                           pref_country: pref_country_value,
//                           pref_state: pref_state_value,
//                           family_val: family_value,
//                           complexion: _complexion_controller.text));
//                     }
//                   },
//                   child:
//                       CommonWidget.manage_profile_update_box(context: context))
//               : const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.grey,
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget build_title(BuildContext contextl, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           AppLocalizations.of(context).public_profile_your_Partner_expectation,
//           style: StyleBtn.style_bold_app_accent_13,
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//       ],
//     );
//   }
//
//   Widget build_general_requirement(BuildContext contextl, AppState state) {
//     _general_requirement_controller.text = state.manageProfileCombineState
//         .partnerExpectationState.partnerExpectationGetResponse.data.general;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //general requirements
//         /// general requirements
//         Text(
//           AppLocalizations.of(context).manage_profile_general_req,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           validator: (val) {
//             if (val == null || val.isEmpty) {
//               return "Field required";
//             }
//             return null;
//           },
//           controller: _general_requirement_controller,
//           decoration: InputStyle.inputDecoration_text_field(
//               hint: "General Requirement"),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//
//         //general requirrements ends
//       ],
//     );
//   }
//
//   Widget build_min_height(BuildContext contextl, AppState state) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// min height
//         Text(
//           AppLocalizations.of(context).manage_profile_min_height,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _min_height_controller,
//           decoration: InputStyle.inputDecoration_text_field(
//               hint: "Min Height (In Feet)"),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//
//         // min height ends
//       ],
//     );
//   }
//
//   Widget build_max_weight(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// max weight
//         Text(
//           AppLocalizations.of(context).manage_profile_max_weight,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _max_weight_controller,
//           decoration:
//               InputStyle.inputDecoration_text_field(hint: "Max weight (IN kg)"),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//
//         // max weight ends
//       ],
//     );
//   }
//
//   Widget build_residence_marital_row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).public_profile_residency_country,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: CommonWidget().buildDropdownButtonFormField(
//                     state.manageProfileCombineState.partnerExpectationState
//                         .profiledropdownResponse.data.countryList, (value) {
//                   residency_country_value = value.id;
//                 }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context)
//                   .advanced_search_screen_marital_status,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 50,
//               child: CommonWidget().buildDropdownButtonFormField(
//                   state.manageProfileCombineState.partnerExpectationState
//                       .profiledropdownResponse.data.maritialStatus, (value) {
//                 marital_status_value = value.id;
//               }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_children_religion_row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).manage_profile_children_acceptable,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: DropdownButtonFormField(
//                     // validator: (val) {
//                     //   if (val == null || val.isEmpty) {
//                     //     return "Required field";
//                     //   }
//                     //   return null;
//                     // },
//                     iconSize: 0.0,
//                     decoration: InputStyle.inputDecoration_text_field(
//                         suffixIcon: Icon(Icons.keyboard_arrow_down)),
//                     value: children_value,
//                     items: items.map<DropdownMenuItem<dynamic>>((e) {
//                       return DropdownMenuItem<dynamic>(
//                         value: e,
//                         child: Text(
//                           e,
//                           style: StyleBtn.style_regular_12,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (dynamic newValue) {
//                       setState(() {
//                         children_value = newValue;
//                       });
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_religion,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 50,
//               child: CommonWidget().buildDropdownButtonFormField(
//                   state.manageProfileCombineState.partnerExpectationState
//                       .profiledropdownResponse.data.religionList, (value) {
//                 religion_value = value.id;
//
//                 caste_value = null;
//                 sub_caste_value = null;
//                 store.dispatch(casteMiddleware(value.id));
//               }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_caste_subcaste_row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).manage_profile_caste,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 width: double.infinity,
//                 child: DropdownButton(
//                     iconSize: 0.0,
//                     isDense: true,
//                     style: TextStyle(color: Colors.black, fontSize: 15),
//                     value: caste_value,
//                     items: state.manageProfileCombineState
//                         .partnerExpectationState.casteResponse.data
//                         .map<DropdownMenuItem<dynamic>>((e) {
//                       return DropdownMenuItem<dynamic>(
//                         value: e.id,
//                         child: Text(
//                           e.name,
//                           style: StyleBtn.style_regular_12,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (dynamic newValue) {
//                       caste_value = newValue;
//                       store.dispatch(subcasteMiddleware(caste_value));
//                       sub_caste_value = null;
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_sub_caste,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               width: double.infinity,
//               child: DropdownButton(
//                   iconSize: 0.0,
//                   isDense: true,
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                   value: sub_caste_value,
//                   items: state.manageProfileCombineState.partnerExpectationState
//                       .subcasteResponse.data
//                       .map<DropdownMenuItem<dynamic>>((e) {
//                     return DropdownMenuItem<dynamic>(
//                       value: e.id,
//                       child: Text(
//                         e.name,
//                         style: StyleBtn.style_regular_12,
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (dynamic newValue) {
//                     sub_caste_value = newValue;
//                   }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_language_smoking_Row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).public_profile_Lang,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: CommonWidget().buildDropdownButtonFormField(
//                     state.manageProfileCombineState.spiritualSocialState
//                         .profiledropdownResponse.data.languageList, (value) {
//                   language_value = value.id;
//                 }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_smoking_acceptable,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 50,
//               child: DropdownButtonFormField(
//                   // validator: (val) {
//                   //   if (val == null || val.isEmpty) {
//                   //     return "Required field";
//                   //   }
//                   //   return null;
//                   // },
//                   iconSize: 0.0,
//                   decoration: InputStyle.inputDecoration_text_field(
//                       suffixIcon: Icon(Icons.keyboard_arrow_down)),
//                   value: smoking_value,
//                   items: items.map<DropdownMenuItem<dynamic>>((e) {
//                     return DropdownMenuItem<dynamic>(
//                       value: e,
//                       child: Text(
//                         e,
//                         style: StyleBtn.style_regular_12,
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (dynamic newValue) {
//                     setState(() {
//                       smoking_value = newValue;
//                     });
//                   }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_education(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// education
//         Text(
//           AppLocalizations.of(context).manage_profile_education,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _education_controller,
//           decoration: InputStyle.inputDecoration_text_field(hint: "Education"),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
//
//   Widget build_profession(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ///profession
//         Text(
//           AppLocalizations.of(context).manage_profile_profession,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _profession_controller,
//           decoration: InputStyle.inputDecoration_text_field(hint: "Profession"),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
//
//   Widget build_drinking_acceptable(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ///drinking acceptable
//
//         Text(
//           AppLocalizations.of(context).manage_profile_drinking_acceptable,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Container(
//           height: 50,
//           child: DropdownButtonFormField(
//               // validator: (val) {
//               //   if (val == null || val.isEmpty) {
//               //     return "Required field";
//               //   }
//               //   return null;
//               // },
//               iconSize: 0.0,
//               decoration: InputStyle.inputDecoration_text_field(
//                   suffixIcon: Icon(Icons.keyboard_arrow_down)),
//               value: drinking_value,
//               items: items.map<DropdownMenuItem<dynamic>>((e) {
//                 return DropdownMenuItem<dynamic>(
//                   value: e,
//                   child: Text(
//                     e,
//                     style: StyleBtn.style_regular_12,
//                   ),
//                 );
//               }).toList(),
//               onChanged: (dynamic newValue) {
//                 setState(() {
//                   drinking_value = newValue;
//                 });
//               }),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
//
//   Widget build_diet_body_Row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).manage_profile_diet,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: DropdownButtonFormField(
//                     // validator: (val) {
//                     //   if (val == null || val.isEmpty) {
//                     //     return "Required field";
//                     //   }
//                     //   return null;
//                     // },
//                     iconSize: 0.0,
//                     decoration: InputStyle.inputDecoration_text_field(
//                         suffixIcon: Icon(Icons.keyboard_arrow_down)),
//                     value: diet_value,
//                     items: items.map<DropdownMenuItem<dynamic>>((e) {
//                       return DropdownMenuItem<dynamic>(
//                         value: e,
//                         child: Text(
//                           e,
//                           style: StyleBtn.style_regular_12,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (dynamic newValue) {
//                       setState(() {
//                         diet_value = newValue;
//                       });
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_body_type,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             TextFormField(
//               controller: _body_controller,
//               decoration:
//                   InputStyle.inputDecoration_text_field(hint: "Body Type"),
//             )
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_personal_value(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// personal value
//         Text(
//           AppLocalizations.of(context).manage_profile_personal_value,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _personal_value_controller,
//           decoration:
//               InputStyle.inputDecoration_text_field(hint: "Personal Value"),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
//
//   Widget build_manglik_counry_Row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).manage_profile_manglik,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: DropdownButton(
//                     iconSize: 0.0,
//                     value: manglik_value,
//                     items: items.map<DropdownMenuItem<dynamic>>((e) {
//                       return DropdownMenuItem<dynamic>(
//                         value: e,
//                         child: Text(
//                           e,
//                           style: StyleBtn.style_regular_12,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (dynamic newValue) {
//                       setState(() {
//                         manglik_value = newValue;
//                       });
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_preferred_country,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 50,
//               child: CommonWidget().buildDropdownButtonFormField(
//                   state.manageProfileCombineState.partnerExpectationState
//                       .profiledropdownResponse.data.countryList, (value) {
//                 pref_country_value = value.id;
//                 store.dispatch(stateMiddleware(value.id));
//                 pref_state_value = null;
//               }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_state_family_value_Row(BuildContext context, AppState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).manage_profile_preferred_state,
//                 style: StyleBtn.style_black_bold_11,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 50,
//                 child: DropdownButton(
//                     isDense: true,
//                     iconSize: 0.0,
//                     value: pref_state_value,
//                     items: state.manageProfileCombineState
//                         .partnerExpectationState.stateResponse.data
//                         .map<DropdownMenuItem<dynamic>>((e) {
//                       return DropdownMenuItem<dynamic>(
//                         enabled: true,
//                         value: e.id,
//                         child: Text(
//                           e.name,
//                           style: StyleBtn.style_regular_12,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (dynamic newValue) {
//                       pref_state_value = newValue;
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).manage_profile_family_value,
//               style: StyleBtn.style_black_bold_11,
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 50,
//               child: CommonWidget().buildDropdownButtonFormField(
//                   state.manageProfileCombineState.partnerExpectationState
//                       .profiledropdownResponse.data.familyValueList, (value) {
//                 family_value = value.id;
//               }),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   Widget build_complexion(BuildContext context, AppState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ///complexion
//         Text(
//           AppLocalizations.of(context).manage_profile_complexion,
//           style: StyleBtn.style_black_bold_11,
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         TextFormField(
//           controller: _complexion_controller,
//           decoration: InputStyle.inputDecoration_text_field(hint: "Complexion"),
//         ),
//
//         const SizedBox(
//           height: 40,
//         ),
//       ],
//     );
//   }
//
//
//   // AppBar buildAppBar(BuildContext context) {
//   //   return AppBar(
//   //     leading: IconButton(
//   //       onPressed: () {
//   //         Navigator.pop(context);
//   //       },
//   //       padding: EdgeInsets.zero,
//   //       constraints: BoxConstraints(),
//   //       icon: Image.asset(
//   //         'assets/icon/icon_pop.png',
//   //         height: 16,
//   //         width: 23,
//   //       ),
//   //     ),
//   //     titleSpacing: 0,
//   //     elevation: 0.0,
//   //     backgroundColor: Colors.white,
//   //     iconTheme: IconThemeData(color: Colors.black),
//   //     title: Text(
//   //       AppLocalizations.of(context).public_profile_Partner_expectation,
//   //       style: StyleBtn.black_16,
//   //     ),
//   //   );
//   // }
// }
