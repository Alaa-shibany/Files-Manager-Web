import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class Validate {
  final BuildContext context;
  Validate({required this.context});
  String? password;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).enter_email;
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return S.of(context).invalid_email_address;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return S.of(context).please_enter_password;
    }

    if (password.length < 6) {
      return S.of(context).password_length;
    }
    return null;
  }

  String? validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_password;
    }
    if (value.length < 6) {
      return S.of(context).password_length;
    }
    // if (value != password) {
    //   return S.of(context).password_must_match;
    // }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_location;
    }

    if (value.length < 6) {
      return S.of(context).password_length;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_user_name;
    }
    if (value.length < 4) {
      return S.of(context).invalid_user_name;
    }
    return null;
  }

  String? validateUserLastName(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_user_name;
    }

    return null;
  }

  String? validateUserFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_user_name;
    }

    return null;
  }

  String? validateSearch(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_at_least_one_word;
    }
    return null;
  }
}
