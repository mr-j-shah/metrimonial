import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/active_members_popup_list.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_shortlist.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/my_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveMembers extends StatefulWidget {
  const ActiveMembers({Key key}) : super(key: key);

  @override
  State<ActiveMembers> createState() => _ActiveMembersState();
}

class _ActiveMembersState extends State<ActiveMembers> {
  var items = active_member_popup_lists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Const.kPaddingHorizontal, vertical: 11),
        child: Column(
          children: [
            buildListViewSeperated(),
          ],
        ),
      ),
    );
  }

  Widget buildListViewSeperated() {
    return Expanded(
      child: Container(
        height: DeviceInfo(context).height,
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 14,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              /// box decoration

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                boxShadow: [
                  // CustombuildBoxShadow(),
                  CommonWidget.box_shadow()
                ],
              ),
              // child0

              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.zircon),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/10508426/pexels-photo-10508426.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load'))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Jane R Lammy',
                                  style: Styles.bold_arsenic_14,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 12,
                                    child: Image.asset(
                                        'assets/icon/icon_premium.png'))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .common_screen_member_id,
                                  style: Styles.regular_storm_grey_12,
                                ),
                                Text(
                                  '765AA707',
                                  style: Styles.bold_storm_grey_12,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    buildActiveMembersPopup(items),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildActiveMembersPopup(List<ActiveMembersPopupList> items) {
    return Container(
      height: 25,
      width: 15,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.more_horiz,
          color: MyTheme.gull_grey,
          size: 20,
        ),
        onSelected: (value) {
          switch (value.toString().toLowerCase()) {
            case 'full profile':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPublicProfile()),
              );
              break;
            case 'response to interest':
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ()),
              // );
              break;
            case 'shortlist':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyShortlist()),
              );
              break;
            case 'ignore':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ignore()),
              );
              break;
            case 'report':
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PublicProfile3()),
              // );
              break;
          }
        },
        itemBuilder: (context) {
          return items
              .map(
                (e) => PopupMenuItem(
                  value: e.text,
                  child: Row(
                    children: [
                      Image.asset(
                        e.icon,
                        height: 16,
                        width: 16,
                        color: MyTheme.arsenic,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        e.text,
                        style: Styles.bold_arsenic_12,
                      ),
                    ],
                  ),
                ),
              )
              .toList();
        },
      ),
    );
  }

  Widget buildAppBarContainer(BuildContext context) {
    return Text(
      AppLocalizations.of(context).active_members_screen_appbar_title,
      style: Styles.bold_app_accent_16,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: buildAppBarContainer(context),
    );
  }
}
