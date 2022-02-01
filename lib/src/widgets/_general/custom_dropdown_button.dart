import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String hint;
  final Color hintColor;
  final Color iconColor;
  final Color backgroundColor;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.hint = "",
    this.hintColor = Colors.black,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {},
        child: Ink(
          height: 36,
          child: DropdownButton(
            items: items,
            onChanged: onChanged,
            hint: Container(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Text(
                hint,
                style: TextStyle(
                  color: hintColor,
                  fontSize: 14,
                ),
              ),
            ),
            underline: const SizedBox.shrink(),
            icon: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: iconColor,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
