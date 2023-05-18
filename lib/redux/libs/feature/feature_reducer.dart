import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_state.dart';

class FetchFeatureAction {
  var payload;

  FetchFeatureAction({this.payload});

  @override
  String toString() {
    return 'FetchFeatureAction{payload: $payload}';
  }
}

FeatureState feature_reducer(FeatureState state, dynamic action) {
  if (action is FetchFeatureAction) {
    return fetch_feature(state, action);
  }
  return state;
}

fetch_feature(FeatureState state, dynamic action) {
  state.feature = action.payload;
  return state;
}
