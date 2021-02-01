import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class AppBottomSheet extends StatelessWidget {
  String title;
  List<Widget> children;

  AppBottomSheet({this.title, this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getBody(),
        ),
      ),
    );
  }

  _getBody() {
    List<Widget> body = [
      SizedBox(
        height: 16,
      ),
      title != null
          ? AutoSizeText(

              title,
              textAlign: TextAlign.left,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Cores.primary, fontSize: 18),
            )
          : Container(),

    ];

    if (children != null && children.isNotEmpty) {
      body.addAll(children);
    }
    return body;
  }
}
