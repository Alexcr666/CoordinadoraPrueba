import 'package:flushbar/flushbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


class AlertWidget {
  message(BuildContext context, String message) {
    Flushbar(
      //title:  "",
      message: message.toString(),
      duration: Duration(seconds: 3),
    )..show(context);
  }
  DateTime now = DateTime.now();

}
