import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
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
      this.fillColor = Colors.white,
      this.maxLines = 1,
      this.borderRadius = 12,
      this.enabled = true,
      this.focusNode,
      this.borderColor = Colors.transparent});

  bool? obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  IconData? icon;
  String? nameLabel;
  Color fillColor;
  String? hintText;
  TextStyle? styleInput;
  bool enabled;
  Color? colorIcon;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  void Function()? onPressedIcon;
  Color borderColor;
  int? maxLines;
  double borderRadius;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameLabel!, style: const TextStyle(color: Colors.white)),
        nameLabel == null || nameLabel!.isEmpty
            ? TextFormField(
                enabled: enabled,
                obscureText: obscureText!,
                keyboardType: keyboardType,
                controller: controller,
                enableSuggestions: true,
                cursorColor: AppColors.primaryColor,
                style: styleInput ??
                    const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                maxLines: maxLines,
                minLines: 1,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      color: Colors.black12, fontWeight: FontWeight.bold),
                  // labelText: nameLabel,
                  labelStyle: styleInput ??
                      const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: fillColor,
                  hoverColor: const Color.fromARGB(255, 231, 231, 231),
                  suffixIcon: icon != null
                      ? IconButton(
                          icon: Icon(icon, color: colorIcon),
                          onPressed: onPressedIcon,
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
                validator: validator,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
              )
            : TextFormField(
                enabled: enabled,
                obscureText: obscureText!,
                keyboardType: keyboardType,
                controller: controller,
                minLines: 1,
                enableSuggestions: true,
                cursorColor: AppColors.primaryColor,
                style: styleInput ??
                    const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      color: Colors.black12, fontWeight: FontWeight.bold),
                  labelText: nameLabel,
                  labelStyle: styleInput ??
                      const TextStyle(
                          color: Colors.transparent,
                          fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: fillColor,
                  suffixIcon: icon != null
                      ? IconButton(
                          icon: Icon(icon, color: colorIcon),
                          onPressed: onPressedIcon,
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  hoverColor: const Color.fromARGB(255, 231, 231, 231),
                ),
                validator: validator,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
              ),
      ],
    );
  }
}
