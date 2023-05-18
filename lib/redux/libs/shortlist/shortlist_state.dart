import 'package:active_matrimonial_flutter_app/models_response/shortlist/add_shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/remove_from_shortlist_response.dart';

class ShortlistState {
  final RemoveFromShortlistResponse removeFromShortlistResponse;
  final AddShortlistResponse addShortlistResponse;
  bool isLoading;
  int index;
  int delIndex;
  bool delete;
  var page;
  bool hasMore;
  String error;
  bool fullReset;

  var shortlistData = [];
  bool isFetching;

  ShortlistState({
    this.isLoading,
    this.shortlistData,
    this.addShortlistResponse,
    this.delete,
    this.error,
    this.index,
    this.isFetching,
    this.removeFromShortlistResponse,
    this.fullReset,
  });

  ShortlistState.initialState()
      : shortlistData = [],
        isFetching = true,
        addShortlistResponse = AddShortlistResponse.initialState(),
        isLoading = false,
        delete = false,
        error = '',
        page = 1,
        fullReset = false,
        hasMore = true,
        removeFromShortlistResponse =
            RemoveFromShortlistResponse.initialState();
}
