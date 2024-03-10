import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  final String? hint;
  final bool hasIcon;
  final TextEditingController textEditingController;
  const MyTextFiled({super.key , this.hint, this.hasIcon = false, required this.textEditingController});

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hint,
        hintStyle:const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
      ),
    );
  }
}