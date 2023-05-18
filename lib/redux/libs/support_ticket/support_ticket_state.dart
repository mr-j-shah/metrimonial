import 'package:active_matrimonial_flutter_app/models_response/support/my_support_categories_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_ticket_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/my_ticket_store_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/support/ticket_reply_response.dart';

class SupportTicketState {
  bool supportLoader;
  bool isFetching;
  var myTickets = [];

  final MyTicketStoreResponse myTicketStoreResponse;
  final MyTicketCategoriesResponse myTicketCategoriesResponse;
  final TicketReplyResponse ticketReplyResponse;

  SupportTicketState(
      {this.isFetching,
      this.supportLoader,
      this.myTickets,
      this.ticketReplyResponse,
      this.myTicketStoreResponse,
      this.myTicketCategoriesResponse});

  SupportTicketState.initialState()
      :
        myTickets = [],
        ticketReplyResponse = TicketReplyResponse.initialState(),
        myTicketCategoriesResponse = MyTicketCategoriesResponse.initialState(),
        myTicketStoreResponse = MyTicketStoreResponse.initialState(),
        isFetching = false,
        supportLoader = false;
}
