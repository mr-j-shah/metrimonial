import 'package:active_matrimonial_flutter_app/models_response/support/my_support_categories_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_ticket_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_ticket_store_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/support_ticket/support_ticket_state.dart';

class SupportLoader {}

class StoreTicketAction {
  var payload;

  StoreTicketAction({this.payload});

  @override
  String toString() {
    return 'FetchTicket{payload: $payload}';
  }
}

SupportTicketState support_ticket_reducer(
    SupportTicketState state, dynamic action) {
  if (action is SupportLoader) {
    return loader(state, action);
  }

  if (action is MyTicketStoreResponse) {
    return my_ticket_store_responose(state, action);
  }

  if (action is MyTicketCategoriesResponse) {
    return my_ticket_catergories_response(state, action);
  }
  if (action is SupportFetch) {
    return fetching(state, action);
  }
  if(action is StoreTicketAction){
    state.myTickets = action.payload;
    return state;
  }
  return state;
}

// my_ticket_response(SupportTicketState state, MyTicketResponse action) {
//   state.myTicketResponse.result = action.result;
//   state.myTicketResponse.links = action.links;
//   state.myTicketResponse.data = action.data;
//   state.myTicketResponse.meta = action.meta;
//   return state;
// }

fetching(SupportTicketState state, SupportFetch action) {
  state.isFetching = !state.isFetching;
  return state;
}

loader(SupportTicketState state, SupportLoader action) {
  state.supportLoader = !state.supportLoader;
  return state;
}

my_ticket_store_responose(
    SupportTicketState state, MyTicketStoreResponse action) {
  state.myTicketStoreResponse.result = action.result;
  state.myTicketStoreResponse.data = action.data;
  return state;
}

my_ticket_catergories_response(
    SupportTicketState state, MyTicketCategoriesResponse action) {
  state.myTicketCategoriesResponse.data = action.data;
  state.myTicketCategoriesResponse.links = action.links;
  state.myTicketCategoriesResponse.meta = action.meta;
  return state;
}

class SupportFetch {}
