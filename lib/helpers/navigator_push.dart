import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class NavigatorPush {
  static push({page}) {
    OneContext().navigator.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static push_remove_untill({page}) {
    OneContext().navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}
