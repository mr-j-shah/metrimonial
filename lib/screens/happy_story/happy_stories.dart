import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_app_bar.dart';
import 'package:active_matrimonial_flutter_app/custom/my_images.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HappyStories extends StatefulWidget {
  const HappyStories({Key key}) : super(key: key);

  @override
  State<HappyStories> createState() => _HappyStoriesState();
}

class _HappyStoriesState extends State<HappyStories> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.dispatch(HappyStoriesReset());
    store.dispatch(happyStoriesMiddleware());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (store.state.happyStoriesState.hasMore) {
          store.dispatch(happyStoriesMiddleware());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(text: AppLocalizations.of(context).happy_story_screen_appbar_title).build(context),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => state.happyStoriesState.hs_loader == false
            ? state.happyStoriesState.happyStoriesResponse.data.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Const.kPaddingHorizontal, vertical: 10),
                    child: buildBody(context, state),
                  )
                : Center(
                    child: Text(AppLocalizations.of(context).common_no_data),
                  )
            :  Center(
                child: CircularProgressIndicator(
                  color: MyTheme.storm_grey,
                ),
              ),
      ),
    );
  }

  Container buildBody(BuildContext context, AppState state) {
    return Container(
      height: DeviceInfo(context).height,
      child: MasonryGridView.count(
        controller: scrollController,
        itemCount: state.happyStoriesState.happyStoriesResponse.data.length + 1,
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        itemBuilder: (context, index) {
          if (index <
              state.happyStoriesState.happyStoriesResponse.data.length) {
            return InkWell(
              onTap: () {
                NavigatorPush.push(

                    page: HappyStoriesDetails(
                      data: state
                          .happyStoriesState.happyStoriesResponse.data[index],
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: DeviceInfo(context).width/2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      child: MyImages.normalImage(state.happyStoriesState.happyStoriesResponse.data[index]
                          .thumbImg),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.4,
                              0.8,
                            ],
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index.isOdd
                              ? Text(
                                  state.happyStoriesState.happyStoriesResponse
                                      .data[index].title,
                                  maxLines: 1,
                                  style: Styles.bold_white_14,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Text(
                                  state.happyStoriesState.happyStoriesResponse
                                      .data[index].title,
                                  maxLines: 2,
                                  style: Styles.bold_white_14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${AppLocalizations.of(context).happy_stories_posted_by} ${state.happyStoriesState.happyStoriesResponse.data[index].userFirstName} ${state.happyStoriesState.happyStoriesResponse.data[index].userLastName}",
                            style: Styles.regular_gull_grey_10,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            "${AppLocalizations.of(context).happy_stories_on} ${state.happyStoriesState.happyStoriesResponse.data[index].date}",
                            style: Styles.regular_gull_grey_10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: state.happyStoriesState.hasMore
                    ?  CircularProgressIndicator(
                        color: MyTheme.storm_grey,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('No more data'),
                        ],
                      ),
              ),
            );
          }
        },
      ),
    );
  }


}
