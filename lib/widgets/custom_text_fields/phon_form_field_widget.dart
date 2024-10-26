import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

class PhonFormFieldWidget extends StatelessWidget {
  const PhonFormFieldWidget({
    super.key,
    required this.controller,
    required this.onCountryCodeChanged,
    required this.initialCountryCode,
  });

  final TextEditingController controller;
  final void Function(String) onCountryCodeChanged;
  final String initialCountryCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).phone_number),
          IntlPhoneField(
            languageCode: 'en',
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              counterStyle: const TextStyle(color: Colors.white),
              helperStyle: const TextStyle(color: Colors.black),
              filled: true,
              floatingLabelStyle:
                  const TextStyle(color: AppColors.primaryColor),
              prefixStyle: const TextStyle(color: Colors.black),
              suffixStyle: const TextStyle(color: Colors.black),
              // labelText: S.of(context).phone_number,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 2.0),
              ),
            ),
            showCountryFlag: true,
            initialCountryCode: 'SY',
            cursorColor: AppColors.primaryColor,
            style: const TextStyle(color: Colors.black),
            dropdownTextStyle: const TextStyle(color: Colors.black),
            onChanged: (phone) {
              onCountryCodeChanged(phone.countryCode);
            },
          ),
        ],
      ),
    );
  }
}
