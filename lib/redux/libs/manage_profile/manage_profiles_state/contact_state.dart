import 'package:active_matrimonial_flutter_app/models_response/manage_profile/contact_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/contact_get_response.dart';

class ContactState {
  final ContactUpdatetResponse contactUpdateResponse;
   bool cdloading;
   bool cdsave;
  final ContactGetResponse contactGetResponse;

  ContactState({this.contactUpdateResponse, this.cdloading, this.cdsave, this.contactGetResponse});

  ContactState.initialState()
      : contactUpdateResponse = ContactUpdatetResponse.initialState(),
        contactGetResponse = ContactGetResponse.initialState(),
        cdloading = false,
        cdsave = false;
}
