import 'package:active_matrimonial_flutter_app/models_response/happy_stories_response.dart';

class HappyStoriesState {
  final HappyStoriesResponse happyStoriesResponse;
  bool fetchData;
  var page;
  bool hasMore;
  bool hs_loader;

  HappyStoriesState({this.happyStoriesResponse});

  HappyStoriesState.initialState()
      : happyStoriesResponse = HappyStoriesResponse.initialState(),
        fetchData = false,
        hs_loader = false,
        page = 1,
        hasMore = true;
}
