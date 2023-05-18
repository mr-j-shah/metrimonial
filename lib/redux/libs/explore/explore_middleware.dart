import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_action.dart';
import 'package:active_matrimonial_flutter_app/repository/explore_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> exploreMiddleware() {
  return (Store<AppState> store) async {
    // try {
    var data = await ExploreRepository().fetchExplore();
    store.dispatch(ExploreStoreAction(payload: data));
    // } catch (e) {
    //   store.dispatch(ExploreFailureAction(error: e.toString()));
    //   debugPrint(e);
    //   return;
    // }
  };
}
