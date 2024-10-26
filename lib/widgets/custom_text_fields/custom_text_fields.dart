import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  CustomTextFields(
      {super.key,
      this.obscureText = false,
      this.keyboardType,
      this.controller,
      this.icon,
      this.nameLabel,
      this.hintText,
      this.styleInput,
      this.colorIcon,
      this.onChanged,
      this.onPressedIcon,
      this.validator,
      this.onFieldSubmitted,
      this.textAlign = TextAlign.start});

  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  IconData? icon;
  String? nameLabel;
  String? hintText;
  TextStyle? styleInput;
  TextAlign? textAlign;
  Color? colorIcon;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  void Function()? onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: obscureText!,
        keyboardType: keyboardType,
        controller: controller,
        enableSuggestions: true,
        style: styleInput ?? const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.transparent),
          labelText: nameLabel,
          labelStyle: styleInput ?? const TextStyle(color: Colors.transparent),
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: icon != null
              ? IconButton(
                  icon: Icon(icon, color: colorIcon),
                  onPressed: onPressedIcon,
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        textAlign: textAlign!,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
