import 'package:active_matrimonial_flutter_app/models_response/happy_stories_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_state.dart';

HappyStoriesState happy_stories_reducer(HappyStoriesState state, dynamic action) {
  if (action is HappyStoriesResponse) {
    return happy_stories_response(state, action);
  }
  if(action is HappyStoriesPaginatorAction){
    return paginate(state, action);
  }
  if(action is HappyStoriesHasMoreToggler){
    return has_more_toggler(state, action);
  }
  if(action is HappyStoriesReset){
    return reset(state, action);
  }
  if(action is HappyStoriesLoader){
    return hs_loader(state, action);
  }
  return state;
}

hs_loader(HappyStoriesState state, HappyStoriesLoader action){
  state.hs_loader = !state.hs_loader;
  return state;
}

reset(HappyStoriesState state, dynamic action){
  state = HappyStoriesState.initialState();
  return state;
}

has_more_toggler(HappyStoriesState state, HappyStoriesHasMoreToggler action){
  state.hasMore = false;
  return state;
}

paginate(HappyStoriesState state, HappyStoriesPaginatorAction action){
  state.happyStoriesResponse.data.addAll(action.data);
  state.fetchData = true;
  state.page = state.page+1;
  return state;
}

happy_stories_response(HappyStoriesState state, HappyStoriesResponse action){
  state.happyStoriesResponse.data = action.data;
  state.happyStoriesResponse.result = action.result;
  state.happyStoriesResponse.meta = action.meta;
  state.happyStoriesResponse.links = action.links;

  return state;

}

class HappyStoriesPaginatorAction{
  var data;

  HappyStoriesPaginatorAction({this.data});
}
class HappyStoriesHasMoreToggler{}
class HappyStoriesReset{}

class HappyStoriesLoader{}
