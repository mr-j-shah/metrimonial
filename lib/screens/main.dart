import 'dart:ui';

import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/connectivity_helper.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_middleware/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_list.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/explore.dart';
import 'package:active_matrimonial_flutter_app/screens/home.dart';
import 'package:active_matrimonial_flutter_app/screens/home_without_login.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectivityHelper().abortIfNotConnected(context, onPop);

    store.dispatch(profiledropdownMiddleware());
  }

  onPop(value) {
    ConnectivityHelper().abortIfNotConnected(context, onPop);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {}
        return true;
      },
      child: Scaffold(
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (_, state) => body(context, state)),
        bottomNavigationBar: buildBottomNavigationContainer(context),
      ),
    );
  }

  Widget body(BuildContext context, AppState state) {
    var isLogin = prefs.getBool(Const.prefIsLogin) ?? false;

    if (_currentIndex == 0) {
      if (isLogin) {
        return Home();
      } else {
        return HomeWithoutLogin();
      }
    } else if (_currentIndex == 1)
      return Explore();
    else if (_currentIndex == 2) {
      if (isLogin == true) {
        return ChatList(
          backButtonAppearance: false,
        );
      } else {
        return Login();
      }
    } else if (_currentIndex == 3) {
      if (isLogin == true) {
        return Account();
      } else {
        return Login();
      }
    }
  }

  Widget buildBottomNavigationContainer(BuildContext context) {
    return Container(
      height: 75,
      child: BottomAppBar(
        color: MyTheme.white,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          elevation: 0.0,
          backgroundColor: MyTheme.white,
          selectedItemColor: MyTheme.app_accent_color,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: MyTheme.storm_grey,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_members.png',
              size: 18.0,
              label: AppLocalizations.of(context).common_active_members,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_explore.png',
              size: 18.0,
              label: AppLocalizations.of(context).common_active_explore,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_chat.png',
              size: 18.0,
              label: AppLocalizations.of(context).common_active_chat,
            ),
            buildBottomNavigationBarItem(
              context,
              icon: 'assets/icon/icon_account.png',
              size: 18.0,
              label: AppLocalizations.of(context).common_active_account,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(BuildContext context,
      {String icon, double size, dynamic label, dynamic page}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageIcon(
          AssetImage(icon),
          size: size,
        ),
      ),
      label: label,
    );
  }
}
