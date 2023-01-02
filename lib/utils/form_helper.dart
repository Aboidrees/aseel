import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInput(
    BuildContext context, {
    Object? initialValue,
    void Function(String)? onChanged,
    bool isTextArea = false,
    bool isNumberInput = false,
    obscureText = false,
    String? Function(String?)? onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      initialValue: initialValue.toString(),
      decoration: fieldDecoration(context, "", "", suffixIcon: suffixIcon),
      obscureText: obscureText,
      maxLines: !isTextArea ? 1 : 3,
      keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
      onChanged: onChanged,
      validator: onValidate,
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
      border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
    );
  }

  static Widget fieldLabel(String labelName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(labelName, textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
    );
  }

  static Widget saveButton(String buttonText, VoidCallback? onTap, {String? color, String? textColor, bool? fullWidth}) {
    return SizedBox(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber, style: BorderStyle.solid, width: 1.0),
            color: Colors.amber,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context, {
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [MaterialButton(onPressed: onPressed, child: Text(buttonText))],
        );
      },
    );
  }
}
