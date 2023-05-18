import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/happy_stories_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/happy_stories/happy_stories_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> happyStoriesMiddleware() {
  return (Store<AppState> store) async {

    if(store.state.happyStoriesState.page == 1){
    store.dispatch(HappyStoriesLoader());

    }

   var  page = store.state.happyStoriesState.page;

    var baseUrl = "${AppConfig.BASE_URL}/happy-stories?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });


      var data = happyStoriesResponseFromJson(response.body);
      if(store.state.happyStoriesState.page == 1){
        store.dispatch(HappyStoriesLoader());
      }


      if(store.state.happyStoriesState.hasMore==true){
        store.dispatch(HappyStoriesPaginatorAction(data: data.data));
      }else{
        store.dispatch(HappyStoriesResponse(
          result: data.result,
          data: data.data,
        ));
      }
      if(store.state.happyStoriesState.happyStoriesResponse.data.length == data.meta.total){
        store.dispatch(HappyStoriesHasMoreToggler());
      }

    } catch (e) {
      debugPrint(e);
      return;
    }
  };
}
