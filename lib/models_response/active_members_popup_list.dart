import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveMembersPopupList {
  String text;
  String icon;
  // String link;

  ActiveMembersPopupList({this.text, this.icon});
}

List<ActiveMembersPopupList> active_member_popup_lists = [
  ActiveMembersPopupList(
    icon: 'assets/icon/icon_full_profile.png',
    text: "Full Profile"
  ),
  ActiveMembersPopupList(
    icon: 'assets/icon/icon_love.png',
    text: 'Response to interest',
  ),
  ActiveMembersPopupList(
    icon: 'assets/icon/icon_shortlist.png',
    text: 'Shortlist',
  ),
  ActiveMembersPopupList(
    icon: 'assets/icon/icon_ignore.png',
    text: 'Ignore',
  ),
  ActiveMembersPopupList(
    icon: 'assets/icon/icon_report.png',
    text: 'Report',
  ),
];
