import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowBasicSearch extends StatelessWidget {
  const ShowBasicSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return Container(
      height: DeviceInfo(context).height,
      child: state.basicSearchState.search_loader == false
          ? state.basicSearchState.basicSearchResponse.data.members.isNotEmpty
              ? ListView.separated(
                  itemCount: state
                      .basicSearchState.basicSearchResponse.data.members.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Const.kPaddingHorizontal),
                      child: GestureDetector(
                        onTap: () {
                          NavigatorPush.push(

                              page: UserPublicProfile(
                                user: state.basicSearchState.basicSearchResponse
                                    .data.members[index],
                              ));
                        },
                        child: Container(
                          width: DeviceInfo(context).width,
                          height: 120.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(0, 5.0),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 72,
                                  width: 72,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child:
                                      MyImages.normalImage(state
                                          .basicSearchState
                                          .basicSearchResponse
                                          .data
                                          .members[index]
                                          .photo),
                                      // Image.network(state
                                      //     .basicSearchState
                                      //     .basicSearchResponse
                                      //     .data
                                      //     .members[index]
                                      //     .photo)


                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.basicSearchState.basicSearchResponse
                                              .data.members[index].firstName +
                                          ' ' +
                                          state
                                              .basicSearchState
                                              .basicSearchResponse
                                              .data
                                              .members[index]
                                              .lastName,
                                      style: Styles.medium_arsenic_14,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .common_screen_member_id,
                                          style: Styles.regular_storm_grey_12,
                                        ),
                                        Text(
                                          state
                                              .basicSearchState
                                              .basicSearchResponse
                                              .data
                                              .members[index]
                                              .code,
                                          style: Styles.bold_storm_grey_12,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "${state.basicSearchState.basicSearchResponse.data.members[index].age} yrs ${state.basicSearchState.basicSearchResponse.data.members[index].height} feet ${state.basicSearchState.basicSearchResponse.data.members[index].maritalStatus}",
                                        style: Styles.regular_storm_grey_12),
                                    Text(
                                        "${state.basicSearchState.basicSearchResponse.data.members[index].religion}, ${state.basicSearchState.basicSearchResponse.data.members[index].caste}",
                                        style: Styles.regular_storm_grey_12)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(AppLocalizations.of(context).common_no_data),
                )
          : Center(
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
        AppLocalizations.of(context).show_search,
        style: Styles.bold_app_accent_16,
      ),
    );
  }
}
