import 'package:flutter/material.dart';
import 'package:projet_formation/app_constant.dart';
import 'package:projet_formation/configration.dart';

class MyBoutton extends StatefulWidget {
  final Function()? onPressed;
  final String? title;
  final Color color;
  final Color textColor;
  const MyBoutton({
    super.key,
    this.onPressed,
    this.title,
    this.color = AppConstants.primaryColor,
    this.textColor = Colors.white,
  });

  @override
  State<MyBoutton> createState() => _MyBouttonState();
}

class _MyBouttonState extends State<MyBoutton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: fullWidth(context) * 0.9,
      height: fullHeight(context) * 0.06,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              elevation: 3,
              foregroundColor: widget.textColor,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize10(context) * 2)),
          child: Text(
            widget.title!,
          )),
    );
  }
}