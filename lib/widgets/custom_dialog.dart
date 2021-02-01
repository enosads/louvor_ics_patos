import 'package:flutter/material.dart';

class CustomDialog extends PopupRoute {
  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  Widget _builder(BuildContext context) {
    return Container();
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}