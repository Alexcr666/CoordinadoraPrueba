import 'package:flutter/material.dart';
//import 'package:qr_on_the_table_flutter/ui/common/widgets/custom_toast.dart';

class InitAction {}

class ErrorAction {
//  const ErrorAction();
  ErrorAction(this.context);

  final BuildContext context;

//Widget showErrorToast({String msg}) =>
// CustomToast(msg: msg, type: CustomToast.ERROR);

// Widget showSuccessToast({String msg}) =>
//   CustomToast(msg: msg, type: CustomToast.SUCCESS);
}

class SaveToastAction {
  const SaveToastAction(this.error);

  final Widget error;
}

class DeleteToastAction {}
