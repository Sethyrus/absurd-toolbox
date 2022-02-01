import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool? obscureText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? labelText;
  final AutovalidateMode? autovalidateMode;

  const AuthInput({
    Key? key,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.obscureText,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.indigo,
              )
            : null,
        labelText: labelText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.indigo,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.indigo,
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
