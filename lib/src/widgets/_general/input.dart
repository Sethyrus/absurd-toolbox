import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool? obscureText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? labelText;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final int maxLines;
  final TextInputAction? textInputAction;

  const Input({
    Key? key,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.obscureText,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.autovalidateMode,
    this.initialValue,
    this.maxLines = 1,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).primaryColor,
              )
            : null,
        labelText: labelText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText ?? false,
      controller: controller,
    );
  }
}
