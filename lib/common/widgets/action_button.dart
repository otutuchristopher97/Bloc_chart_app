import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool filled;
  final String? title;
  final Widget? child;
  final Color? titleColor;
  final Color? borderColor;
  final Function() onPressed;

  const ActionButton({
    Key? key,
    this.title,
    this.child,
    this.titleColor,
    this.borderColor,
    this.filled = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: child ??
            Text(
              title!,
            ),
      ),
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith((states) {
          return filled ? null : BorderSide(color: borderColor!);
        }),
        elevation: MaterialStateProperty.resolveWith((states) {
          return filled ? 4 : 0;
        }),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30));
        }),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return filled ? Colors.blue : Colors.white;
        }),
      ),
      onPressed: onPressed,
    );
  }
}
