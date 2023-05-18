import 'package:flutter/material.dart';

import 'package:one_context/one_context.dart';

class MyScaffoldMessenger {

  sf_messenger({@required String text, Color color}) {

    OneContext().showSnackBar(
        builder: (_) => SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: color,
            content: Text(text)));
  }
}


