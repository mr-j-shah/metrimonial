import 'dart:async';
import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/explore/explore_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/landing_page.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

SharedPreferences prefs;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: AppConfig.app_name,
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.dispatch(exploreMiddleware());
    store.dispatch(featureCheckMiddleware());
    store.dispatch(appInfoMiddleware());
    store.dispatch(addonCheckMiddleware());



    _initPackageInfo();
    startTimer();

  }
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

//

  startTimer() async {
    prefs = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    return Timer(duration, onBoardingPage);
  }

  onBoardingPage() {
    /// if isLogin then will go directly main page
    /// otherwise will show landing page

    var status = prefs.getBool(Const.prefIsLogin) ?? false;
    var isViewed = prefs.getBool(Const.isViewed) ?? false;

    if (status == true) {
      store.dispatch(homeMiddleware());
      NavigatorPush.push( page: const Main());
    } else {
      if (isViewed) {
        NavigatorPush.push( page: const Main());
      } else {
        NavigatorPush.push( page: const LandingPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    print(_packageInfo);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        body: Container(
          width: DeviceInfo(context).width,
          height: DeviceInfo(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.8, 1),
              colors: [
                MyTheme.gradient_color_1,
                MyTheme.gradient_color_2,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 72,
                    width: 85,
                    child: Image.asset(
                      'assets/logo/app_logo.png',
                      color: Colors.white,
                    ),
                    // child: Image.network(state.appInfoState.appInfoResponse.data.systemLogo),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    AppConfig.app_name,
                    style: Styles.medium_white_22,
                  ),
                ],
              ),
              Positioned(
                bottom: 116,
                child: Column(
                  children: [
                    Text(
                      'v ${_packageInfo.version}',
                      style: Styles.medium_white_12,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      AppConfig.copyright_text,
                      style: Styles.regular_light_grey_12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
