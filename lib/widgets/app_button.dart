import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;
  bool showProgress;
  bool expanded;
  Color color;
  Color textColor;
  Color borderColor;

  AppButton(this.text,
      {this.onPressed,
      this.showProgress = false,
      this.expanded = true,
      this.color,
      this.textColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? MediaQuery.of(context).size.width : null,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),

        ),
        color: color != null ? color : Colors.white,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor != null ? textColor : Colors.white,
                ),
              ),
        padding: EdgeInsets.all(12),
        onPressed: onPressed,
      ),
    );
  }
}
