import 'package:flutter/services.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  bool data;
  bool hora;
  bool telefone;
  bool autofocus;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  ValueChanged<String> onFieldSubmitted;
  ValueChanged<String> onChanged;
  Color color;
  bool readOnly;

  AppText({
    this.label,
    this.hint,
    this.focusNode,
    this.controller,
    this.password = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.nextFocus,
    this.onFieldSubmitted,
    this.onChanged,
    this.telefone = false,
    this.data = false,
    this.hora = false,
    this.autofocus = false,
    this.color,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: telefone
          ? [
              MaskTextInputFormatter(
                  mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')})
            ]
          : data
              ? [
                  MaskTextInputFormatter(
                      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')})
                ]
              : hora
                  ? [
                      MaskTextInputFormatter(
                          mask: '##:##', filter: {"#": RegExp(r'[0-9]')})
                    ]
                  : null,
      onChanged: onChanged,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: Cores.primary,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted != null
          ? onFieldSubmitted
          : (next) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
      style: TextStyle(
        color: color != null ? color : Cores.primary,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          hintText: hint,
          labelText: label),
    );
  }
}
