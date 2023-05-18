import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/shortlist/shortlist_reducer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

// ThunkAction<AppState> shortlistMiddleware() {
//   return (Store<AppState> store) async {
//     if (store.state.shortlistState.page == 1) {
//       store.dispatch(LoadAction());
//     }
//     var page = store.state.shortlistState.page;
//     var baseUrl = "${AppConfig.BASE_URL}/member/my-shortlists?page=$page";
//     var accessToken = prefs.getString(Const.accessToken);
//
//     try {
//       var response = await http.get(Uri.parse(baseUrl), headers: {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $accessToken",
//       });
//
//       var data = shortlistResponseFromJson(response.body);
//       // calling load action
//       if (store.state.shortlistState.page == 1) {
//         store.dispatch(LoadAction());
//       }
//
//       if (store.state.shortlistState.hasMore == true) {
//         store.dispatch(ShortlistPaginator(data: data.data));
//       } else {
//         store.dispatch(ShortlistResponse(
//             result: data.result,
//             data: data.data,
//             meta: data.meta,
//             links: data.links));
//       }
//
//       if (store.state.shortlistState.shortlistResponse.data.length ==
//           data.meta.total) {
//         store.dispatch(ShortlistHasMoreToggler());
//       }
//     } catch (e) {
//       debugPrint(e);
//       return;
//     }
//   };
// }

ThunkAction<AppState> shortlistMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.shortlistState.page;

    try {
      var data = await ShortlistRepository().fetchShortlist(page: page);
      store.dispatch(StoreShortlist(payload: data));
    } catch (e) {
      // store.dispatch(ShortlistFailureAction(error: 'Failed To Fetch Data.'));
      store.dispatch(ShortlistFailureAction(error: e.toString()));
      return;
    }
  };
}


class ShortlistRepository {
  Future<ShortlistResponse> fetchShortlist({page = 1}) async {
    try {
      var baseUrl = "${AppConfig.BASE_URL}/member/my-shortlists?page=$page";
      var accessToken = prefs.getString(Const.accessToken);

      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      return shortlistResponseFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}