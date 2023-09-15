import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final EdgeInsets margin;
  final bool isPasswordField;
  final IconData? prefixIconData;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.labelText,
    this.controller,
    this.prefixIconData,
    this.isPasswordField = false,
    this.margin = const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: widget.isPasswordField ? obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: obscureText
                      ? Icon(
                          Icons.visibility_off,
                        )
                      : Icon(
                          Icons.visibility,
                        ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : SizedBox.shrink(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: (value) {
          return widget.validator != null ? widget.validator!(value) : null;
        },
      ),
    );
  }
}
