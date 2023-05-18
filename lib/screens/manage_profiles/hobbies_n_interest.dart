import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_scaffold_messenger.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/get_manage_profile/hobbies_interest_get_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/hobbies_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/hobbies_interest_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HobbiesInterest extends StatefulWidget {
  const HobbiesInterest({Key key}) : super(key: key);

  @override
  State<HobbiesInterest> createState() => _HobbiesInterestState();
}

class _HobbiesInterestState extends State<HobbiesInterest> {
  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      onInit: (store){
        print(store.state.manageProfileCombineState.hobbiesInterestState
            .hobbiesInterestGetResponse.result);
        print(store.state.manageProfileCombineState.hobbiesInterestState.hobbiesInterestGetResponse.data?.hobbies);

        HobbiesInterestState state = store.state.manageProfileCombineState.hobbiesInterestState as HobbiesInterestState;
        if(store.state.manageProfileCombineState.hobbiesInterestState
                .hobbiesInterestGetResponse.result){

          state.hobbies.text=state.hobbiesInterestGetResponse.data.hobbies;
          state.interests.text=state.hobbiesInterestGetResponse.data.interests;
          state.music.text=state.hobbiesInterestGetResponse.data.music;
          state.books.text=state.hobbiesInterestGetResponse.data.books;
          state.movies.text=state.hobbiesInterestGetResponse.data.movies;
          state.tv_shows.text=state.hobbiesInterestGetResponse.data.tvShows;
          state.sports.text=state.hobbiesInterestGetResponse.data.sports;
          state.fitness_activites.text=state.hobbiesInterestGetResponse.data.fitnessActivities;
          state.cuisines.text=state.hobbiesInterestGetResponse.data.cuisines;
          state.dress_styles.text=state.hobbiesInterestGetResponse.data.dressStyles;
        }


        print(state.dress_styles.text);


      },
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal, vertical: 11),
            child: SingleChildScrollView(
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
        AppLocalizations.of(context).public_profile_hobbies_n_interest,
        style: Styles.bold_arsenic_16,
      ),
    );
  }

  build_title(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).public_profile_your_hobbies_n_interest,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  build_hobbies(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_hobbies,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.hobbiesInterestState.hobbies,
          hint: "Hobbies",
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_interests(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
            text: AppLocalizations.of(context).manage_profile_interests,
            style: Styles.bold_arsenic_12,
            controller: state.manageProfileCombineState.hobbiesInterestState.interests,
            hint: "Interests"),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_music(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_music,
          style: Styles.bold_arsenic_12,
          hint: "Music",
          controller: state.manageProfileCombineState.hobbiesInterestState.music,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_books(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_books,
          style: Styles.bold_arsenic_12,
          hint: "Books ",
          controller: state.manageProfileCombineState.hobbiesInterestState.books,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_movies(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_movies,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.hobbiesInterestState.movies,
          hint: "Movies",
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_tv_shows(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_tv_shows,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.hobbiesInterestState.tv_shows,
          hint: "Tv Shows",
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_sports(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_sports,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.hobbiesInterestState.sports,
          hint: "Sports",
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_fitness_acti(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_fitness_activities,
          hint: "Fitness Activities",
          controller: state.manageProfileCombineState.hobbiesInterestState.fitness_activites,
          style: Styles.bold_arsenic_12,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  build_cuisines(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_cuisines,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState.hobbiesInterestState.cuisines,
          hint: "Cuisines",
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget build_dresss_styles(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicFormWidget(
          text: AppLocalizations.of(context).manage_profile_dress_styles,style: Styles.bold_arsenic_12,hint: "Dress Styles",controller:state.manageProfileCombineState.hobbiesInterestState.dress_styles,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_title(context, state),
        build_hobbies(context, state),
        build_interests(context, state),
        build_music(context, state),
        build_books(context, state),
        build_movies(context, state),
        build_tv_shows(context, state),
        build_sports(context, state),
        build_fitness_acti(context, state),
        build_cuisines(context, state),
        build_dresss_styles(context, state),
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (!_formKey.currentState.validate()) {
              MyScaffoldMessenger()
                  .sf_messenger(text: "Form's not validated!");
            } else {
              store.dispatch(hobbiesInterestMiddleware(
                  context: context,
                  hobbies: state.manageProfileCombineState.hobbiesInterestState.hobbies.text,
                  interests: state.manageProfileCombineState.hobbiesInterestState.interests.text,
                  music: state.manageProfileCombineState.hobbiesInterestState.music.text,
                  books: state.manageProfileCombineState.hobbiesInterestState.books.text,
                  movies: state.manageProfileCombineState.hobbiesInterestState.movies.text,
                  tv_shows: state.manageProfileCombineState.hobbiesInterestState.tv_shows.text,
                  sports: state.manageProfileCombineState.hobbiesInterestState.sports.text,
                  fitness_activites: state.manageProfileCombineState.hobbiesInterestState.fitness_activites.text,
                  cuisines: state.manageProfileCombineState.hobbiesInterestState.cuisines.text,
                  dress_styles: state.manageProfileCombineState.hobbiesInterestState.dress_styles.text));
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
              child: state.manageProfileCombineState.hobbiesInterestState
                          .isLoading ==
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
        ),
      ],
    );
  }
}
