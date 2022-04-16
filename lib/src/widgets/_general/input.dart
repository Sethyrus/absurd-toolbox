import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Input extends StatefulWidget {
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
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String? _error;

  String? _validate(String? val) {
    if (widget.validator != null) {
      String? error = widget.validator!(val);

      if (_error != error) {
        Future.delayed(
          Duration.zero,
          () => setState(() => _error = error),
        );
      }

      return error;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              depth: NeumorphicTheme.embossDepth(context),
              boxShape: const NeumorphicBoxShape.stadium(),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 18,
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: NeumorphicIcon(
                      widget.prefixIcon!,
                      // style: const NeumorphicStyle(color: Colors.white),
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        intensity: 0.8,
                        surfaceIntensity: 0.5,
                        depth: 2,
                        lightSource: LightSource.topLeft,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      errorStyle: TextStyle(
                        height: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  child: Expanded(
                    child: TextFormField(
                      maxLines: widget.maxLines,
                      initialValue: widget.initialValue,
                      autovalidateMode: widget.autovalidateMode,
                      textInputAction: widget.textInputAction,
                      decoration: InputDecoration.collapsed(
                        hintText: widget.labelText,
                        // alignLabelWithHint: maxLines > 1,
                        // prefixIcon: prefixIcon != null
                        //     ? Icon(
                        //         prefixIcon,
                        //         color: Theme.of(context).primaryColor,
                        //       )
                        //     : null,
                        // labelText: labelText,
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     width: 2,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        // ),
                        // floatingLabelStyle: TextStyle(
                        //   color: Theme.of(context).primaryColor,
                        // ),
                      ),
                      keyboardType: widget.keyboardType,
                      validator: _validate,
                      onSaved: widget.onSaved,
                      obscureText: widget.obscureText ?? false,
                      controller: widget.controller,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
