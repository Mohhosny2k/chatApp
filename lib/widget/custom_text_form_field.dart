import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  CustomTextFormFeild({this.hientText, this.onChanged,this.obscuretxxt=false, super.key});
  String? hientText;
  Function(String)? onChanged;
  bool? obscuretxxt;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretxxt!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hientText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
