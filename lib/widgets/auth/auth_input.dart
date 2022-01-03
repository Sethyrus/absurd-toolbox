import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool? obscureText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? labelText;

  AuthInput({
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.obscureText,
    this.controller,
    this.prefixIcon,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.indigo.shade400,
              )
            : null,
        labelText: labelText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.indigo.shade400,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.indigo.shade400,
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
