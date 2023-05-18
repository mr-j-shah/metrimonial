import 'package:active_matrimonial_flutter_app/models_response/manage_profile/contact_update_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/contact_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/contact_state.dart';

class Cdloader {}

class Cdsave {}

ContactState contact_reducer(ContactState state, dynamic action) {
  if (action is ContactUpdatetResponse) {
    return contact_update_response(state, action);
  }
  if (action is Cdloader) {
    return cd_loader(state, action);
  }
  if (action is Cdsave) {
    return cd_save(state, action);
  }
  if (action is ContactGetResponse) {
    return contact_get_response(state, action);
  }

  return state;
}

contact_update_response(ContactState state, ContactUpdatetResponse action) {
  state.contactUpdateResponse.result = action.result;
  state.contactUpdateResponse.message = action.message;
  return state;
}

cd_loader(ContactState state, Cdloader action) {
  state.cdloading = !state.cdloading;
  return state;
}

cd_save(ContactState state, Cdsave action) {
  state.cdsave = !state.cdsave;
  return state;
}

contact_get_response(ContactState state, ContactGetResponse action) {
  state.contactGetResponse.result = action.result;
  state.contactGetResponse.data = action.data;

  return state;
}
