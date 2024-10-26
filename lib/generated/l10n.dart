// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi`
  String get welcome {
    return Intl.message(
      'Hi',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get welcome_to {
    return Intl.message(
      'Welcome to',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Pull Up`
  String get pull_up {
    return Intl.message(
      'Pull Up',
      name: 'pull_up',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get enter_email {
    return Intl.message(
      'Please Enter Your Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get please_enter_user_name {
    return Intl.message(
      'Please enter your name',
      name: 'please_enter_user_name',
      desc: '',
      args: [],
    );
  }

  /// `User name must be 4 characters at least`
  String get invalid_user_name {
    return Intl.message(
      'User name must be 4 characters at least',
      name: 'invalid_user_name',
      desc: '',
      args: [],
    );
  }

  /// `You can not add more that 3 numbers`
  String get cannot_add_more_numbers {
    return Intl.message(
      'You can not add more that 3 numbers',
      name: 'cannot_add_more_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your registered user name to verify the account`
  String get please_enter_your_registered_user_name {
    return Intl.message(
      'Please enter your registered user name to verify the account',
      name: 'please_enter_your_registered_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to verify the account`
  String get please_enter_your_registered_email {
    return Intl.message(
      'Please enter your email to verify the account',
      name: 'please_enter_your_registered_email',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forget_password {
    return Intl.message(
      'Forget password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get create_account {
    return Intl.message(
      'Register Now',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `If you do not have an account`
  String get dont_have_account {
    return Intl.message(
      'If you do not have an account',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Where Efficiency Meets\nEmpowerment`
  String get welcome_auth_message {
    return Intl.message(
      'Where Efficiency Meets\nEmpowerment',
      name: 'welcome_auth_message',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Links`
  String get links {
    return Intl.message(
      'Links',
      name: 'links',
      desc: '',
      args: [],
    );
  }

  /// `Random`
  String get random {
    return Intl.message(
      'Random',
      name: 'random',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `coast`
  String get coast {
    return Intl.message(
      'coast',
      name: 'coast',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Book a meeting`
  String get Book_a_meeting {
    return Intl.message(
      'Book a meeting',
      name: 'Book_a_meeting',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `I scanned`
  String get i_scanned {
    return Intl.message(
      'I scanned',
      name: 'i_scanned',
      desc: '',
      args: [],
    );
  }

  /// `Scanned me`
  String get scanned_me {
    return Intl.message(
      'Scanned me',
      name: 'scanned_me',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// ` Scanner Badge`
  String get scanner_badge {
    return Intl.message(
      ' Scanner Badge',
      name: 'scanner_badge',
      desc: '',
      args: [],
    );
  }

  /// `Badge`
  String get badge {
    return Intl.message(
      'Badge',
      name: 'badge',
      desc: '',
      args: [],
    );
  }

  /// `Badge Scanner`
  String get badge_scanner {
    return Intl.message(
      'Badge Scanner',
      name: 'badge_scanner',
      desc: '',
      args: [],
    );
  }

  /// `Exhibitors`
  String get exhibitors {
    return Intl.message(
      'Exhibitors',
      name: 'exhibitors',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Diary`
  String get diary {
    return Intl.message(
      'Diary',
      name: 'diary',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `My Agenda`
  String get my_agenda {
    return Intl.message(
      'My Agenda',
      name: 'my_agenda',
      desc: '',
      args: [],
    );
  }

  /// `Meeting`
  String get meeting {
    return Intl.message(
      'Meeting',
      name: 'meeting',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Reconnect`
  String get reconnect {
    return Intl.message(
      'Reconnect',
      name: 'reconnect',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Join with Code`
  String get join_with_code {
    return Intl.message(
      'Join with Code',
      name: 'join_with_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enter_password {
    return Intl.message(
      'Enter password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure you are connected to the Internet`
  String get internet_connect_field {
    return Intl.message(
      'Please make sure you are connected to the Internet',
      name: 'internet_connect_field',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Job Opportunity`
  String get job_opportunity {
    return Intl.message(
      'Job Opportunity',
      name: 'job_opportunity',
      desc: '',
      args: [],
    );
  }

  /// `Training`
  String get training {
    return Intl.message(
      'Training',
      name: 'training',
      desc: '',
      args: [],
    );
  }

  /// `Feed Back`
  String get feed_back {
    return Intl.message(
      'Feed Back',
      name: 'feed_back',
      desc: '',
      args: [],
    );
  }

  /// `Conferences`
  String get conferences {
    return Intl.message(
      'Conferences',
      name: 'conferences',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Badge Preview`
  String get badgePreview {
    return Intl.message(
      'Badge Preview',
      name: 'badgePreview',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get visitor {
    return Intl.message(
      'Visitor',
      name: 'visitor',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Scan Result`
  String get scan_result {
    return Intl.message(
      'Scan Result',
      name: 'scan_result',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `am`
  String get am {
    return Intl.message(
      'am',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `pm`
  String get pm {
    return Intl.message(
      'pm',
      name: 'pm',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget_password_app {
    return Intl.message(
      'Forget Password',
      name: 'forget_password_app',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rateUs {
    return Intl.message(
      'Rate us',
      name: 'rateUs',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get appLanguage {
    return Intl.message(
      'App language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Remove account`
  String get removeAccount {
    return Intl.message(
      'Remove account',
      name: 'removeAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove your account?`
  String get doYouWantToRemoveAccount {
    return Intl.message(
      'Do you want to remove your account?',
      name: 'doYouWantToRemoveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get show_less {
    return Intl.message(
      'Show less',
      name: 'show_less',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get read_more {
    return Intl.message(
      'Read More',
      name: 'read_more',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback`
  String get your_feedback {
    return Intl.message(
      'Your feedback',
      name: 'your_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rate_us {
    return Intl.message(
      'Rate us',
      name: 'rate_us',
      desc: '',
      args: [],
    );
  }

  /// `Give your rating`
  String get give_your_rating {
    return Intl.message(
      'Give your rating',
      name: 'give_your_rating',
      desc: '',
      args: [],
    );
  }

  /// `Type your comment`
  String get type_your_comment {
    return Intl.message(
      'Type your comment',
      name: 'type_your_comment',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment`
  String get write_your_comment {
    return Intl.message(
      'Write your comment',
      name: 'write_your_comment',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get app_language {
    return Intl.message(
      'App language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Remove account`
  String get remove_account {
    return Intl.message(
      'Remove account',
      name: 'remove_account',
      desc: '',
      args: [],
    );
  }

  /// `Overall Experience`
  String get overall_experience {
    return Intl.message(
      'Overall Experience',
      name: 'overall_experience',
      desc: '',
      args: [],
    );
  }

  /// `Ease of Use`
  String get ease_of_use {
    return Intl.message(
      'Ease of Use',
      name: 'ease_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Event Organization`
  String get event_organization {
    return Intl.message(
      'Event Organization',
      name: 'event_organization',
      desc: '',
      args: [],
    );
  }

  /// `What did you like the most about this event?`
  String get question1 {
    return Intl.message(
      'What did you like the most about this event?',
      name: 'question1',
      desc: '',
      args: [],
    );
  }

  /// `What can we improve for future events?`
  String get question2 {
    return Intl.message(
      'What can we improve for future events?',
      name: 'question2',
      desc: '',
      args: [],
    );
  }

  /// `Is there anything else you would like to share about your experience?`
  String get question3 {
    return Intl.message(
      'Is there anything else you would like to share about your experience?',
      name: 'question3',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to the email`
  String get enter_the_code {
    return Intl.message(
      'Enter the code sent to the email',
      name: 'enter_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email address`
  String get enter_email_plz {
    return Intl.message(
      'Please enter an email address',
      name: 'enter_email_plz',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalid_email_address {
    return Intl.message(
      'Invalid email address',
      name: 'invalid_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your password`
  String get please_enter_password {
    return Intl.message(
      'Please Enter Your password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_length',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newpassword {
    return Intl.message(
      'New password',
      name: 'newpassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter password`
  String get reenter_password {
    return Intl.message(
      'Re-enter password',
      name: 'reenter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must match`
  String get password_must_match {
    return Intl.message(
      'Password must match',
      name: 'password_must_match',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your settings.`
  String get no_internet {
    return Intl.message(
      'No internet connection. Please check your settings.',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Login failed.\nPlease check your email and password.`
  String get login_faild {
    return Intl.message(
      'Login failed.\nPlease check your email and password.',
      name: 'login_faild',
      desc: '',
      args: [],
    );
  }

  /// `We are experiencing some technical issues on our end.\nPlease try again later.`
  String get server_error {
    return Intl.message(
      'We are experiencing some technical issues on our end.\nPlease try again later.',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Pin is incorrect`
  String get pin_is_incorrect {
    return Intl.message(
      'Pin is incorrect',
      name: 'pin_is_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get FAQs {
    return Intl.message(
      'FAQs',
      name: 'FAQs',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired due to inactivity.\nPlease log in again to continue.`
  String get session_expired {
    return Intl.message(
      'Your session has expired due to inactivity.\nPlease log in again to continue.',
      name: 'session_expired',
      desc: '',
      args: [],
    );
  }

  /// `We could not find an account with that email. Please check the address`
  String get dont_found_account {
    return Intl.message(
      'We could not find an account with that email. Please check the address',
      name: 'dont_found_account',
      desc: '',
      args: [],
    );
  }

  /// `You do not have new notifications yet`
  String get no_notifications {
    return Intl.message(
      'You do not have new notifications yet',
      name: 'no_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Promoter`
  String get promoter {
    return Intl.message(
      'Promoter',
      name: 'promoter',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read notifications`
  String get mark_notificatoin {
    return Intl.message(
      'Mark all as read notifications',
      name: 'mark_notificatoin',
      desc: '',
      args: [],
    );
  }

  /// `Organized Events`
  String get organized_events {
    return Intl.message(
      'Organized Events',
      name: 'organized_events',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Additional Info`
  String get additional_info {
    return Intl.message(
      'Additional Info',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `Book a meet`
  String get book_meet {
    return Intl.message(
      'Book a meet',
      name: 'book_meet',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Your Appointment`
  String get your_appointment {
    return Intl.message(
      'Your Appointment',
      name: 'your_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `We have successfully received your appointment request,and we will notify you once your appointment has been confirmed`
  String get appointment_success {
    return Intl.message(
      'We have successfully received your appointment request,and we will notify you once your appointment has been confirmed',
      name: 'appointment_success',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Server is down`
  String get server_down {
    return Intl.message(
      'Server is down',
      name: 'server_down',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch conferences`
  String get conferences_error_message {
    return Intl.message(
      'Failed to fetch conferences',
      name: 'conferences_error_message',
      desc: '',
      args: [],
    );
  }

  /// `We have successfully received your job apply request,and we will notify you once your apply has been confirmed`
  String get job_success {
    return Intl.message(
      'We have successfully received your job apply request,and we will notify you once your apply has been confirmed',
      name: 'job_success',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Required Skills`
  String get skills {
    return Intl.message(
      'Required Skills',
      name: 'skills',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get job_title {
    return Intl.message(
      'Job Title',
      name: 'job_title',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Birth of date`
  String get bod {
    return Intl.message(
      'Birth of date',
      name: 'bod',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get whatsapp_number {
    return Intl.message(
      'Whatsapp',
      name: 'whatsapp_number',
      desc: '',
      args: [],
    );
  }

  /// `Events work`
  String get events_work {
    return Intl.message(
      'Events work',
      name: 'events_work',
      desc: '',
      args: [],
    );
  }

  /// `Experience in hosting`
  String get experience_in_hosting {
    return Intl.message(
      'Experience in hosting',
      name: 'experience_in_hosting',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get years {
    return Intl.message(
      'Years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Number of staff needed`
  String get number_of_staff_needed {
    return Intl.message(
      'Number of staff needed',
      name: 'number_of_staff_needed',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `No event now`
  String get no_event {
    return Intl.message(
      'No event now',
      name: 'no_event',
      desc: '',
      args: [],
    );
  }

  /// `Your courses`
  String get your_courses {
    return Intl.message(
      'Your courses',
      name: 'your_courses',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get h {
    return Intl.message(
      'h',
      name: 'h',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get conti {
    return Intl.message(
      'Continue',
      name: 'conti',
      desc: '',
      args: [],
    );
  }

  /// `Provide by`
  String get provided_by {
    return Intl.message(
      'Provide by',
      name: 'provided_by',
      desc: '',
      args: [],
    );
  }

  /// `You already applied to this course`
  String get you_already_applied {
    return Intl.message(
      'You already applied to this course',
      name: 'you_already_applied',
      desc: '',
      args: [],
    );
  }

  /// `Let others scan your QR to connect with you instantly!`
  String get let_other_scan {
    return Intl.message(
      'Let others scan your QR to connect with you instantly!',
      name: 'let_other_scan',
      desc: '',
      args: [],
    );
  }

  /// `Can not find your QR`
  String get qr_notfound {
    return Intl.message(
      'Can not find your QR',
      name: 'qr_notfound',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get mon {
    return Intl.message(
      'Mon',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tue {
    return Intl.message(
      'Tue',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wed {
    return Intl.message(
      'Wed',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thu {
    return Intl.message(
      'Thu',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get fri {
    return Intl.message(
      'Fri',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get sat {
    return Intl.message(
      'Sat',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sun {
    return Intl.message(
      'Sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Search field is empty`
  String get field_empty {
    return Intl.message(
      'Search field is empty',
      name: 'field_empty',
      desc: '',
      args: [],
    );
  }

  /// `You already have the data`
  String get already_have_data {
    return Intl.message(
      'You already have the data',
      name: 'already_have_data',
      desc: '',
      args: [],
    );
  }

  /// `Scan cancelled`
  String get scan_cancelled {
    return Intl.message(
      'Scan cancelled',
      name: 'scan_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Scan failed`
  String get scan_failed {
    return Intl.message(
      'Scan failed',
      name: 'scan_failed',
      desc: '',
      args: [],
    );
  }

  /// `You can not scan yourself`
  String get you_can_not_scan_yourself {
    return Intl.message(
      'You can not scan yourself',
      name: 'you_can_not_scan_yourself',
      desc: '',
      args: [],
    );
  }

  /// `You already scanned this contact`
  String get you_already_scanned_this_contact {
    return Intl.message(
      'You already scanned this contact',
      name: 'you_already_scanned_this_contact',
      desc: '',
      args: [],
    );
  }

  /// `Success scan you will find the new contact in your lead`
  String get success_scan_you_will_find_the_new_contact_in_your_lead {
    return Intl.message(
      'Success scan you will find the new contact in your lead',
      name: 'success_scan_you_will_find_the_new_contact_in_your_lead',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get end_time {
    return Intl.message(
      'End time',
      name: 'end_time',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get start_time {
    return Intl.message(
      'Start time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Information about the conference`
  String get info_conference {
    return Intl.message(
      'Information about the conference',
      name: 'info_conference',
      desc: '',
      args: [],
    );
  }

  /// `Seats`
  String get seats {
    return Intl.message(
      'Seats',
      name: 'seats',
      desc: '',
      args: [],
    );
  }

  /// `Lecturer`
  String get lecturer {
    return Intl.message(
      'Lecturer',
      name: 'lecturer',
      desc: '',
      args: [],
    );
  }

  /// `Download contact`
  String get download_contact {
    return Intl.message(
      'Download contact',
      name: 'download_contact',
      desc: '',
      args: [],
    );
  }

  /// `You already have a pending request`
  String get you_already_have_a_pending_request {
    return Intl.message(
      'You already have a pending request',
      name: 'you_already_have_a_pending_request',
      desc: '',
      args: [],
    );
  }

  /// `Your request is being processed`
  String get your_request_is_being_processed {
    return Intl.message(
      'Your request is being processed',
      name: 'your_request_is_being_processed',
      desc: '',
      args: [],
    );
  }

  /// `Some of your answers are wrong please check again before submit`
  String get some_ofyouranswers_worng {
    return Intl.message(
      'Some of your answers are wrong please check again before submit',
      name: 'some_ofyouranswers_worng',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations all your answers are correct`
  String get congratulations {
    return Intl.message(
      'Congratulations all your answers are correct',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Please answer all the questions`
  String get please_answer_all {
    return Intl.message(
      'Please answer all the questions',
      name: 'please_answer_all',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully registered for the course. You can find it in your courses`
  String get you_registered_course {
    return Intl.message(
      'You have successfully registered for the course. You can find it in your courses',
      name: 'you_registered_course',
      desc: '',
      args: [],
    );
  }

  /// `You already done this level`
  String get you_already_answered {
    return Intl.message(
      'You already done this level',
      name: 'you_already_answered',
      desc: '',
      args: [],
    );
  }

  /// `You are not at any event now`
  String get you_are_not_at_any_event_now {
    return Intl.message(
      'You are not at any event now',
      name: 'you_are_not_at_any_event_now',
      desc: '',
      args: [],
    );
  }

  /// `Skills`
  String get normal_skills {
    return Intl.message(
      'Skills',
      name: 'normal_skills',
      desc: '',
      args: [],
    );
  }

  /// `Skill`
  String get skill {
    return Intl.message(
      'Skill',
      name: 'skill',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Events feedback`
  String get events_feedback {
    return Intl.message(
      'Events feedback',
      name: 'events_feedback',
      desc: '',
      args: [],
    );
  }

  /// `You did not reach to this level yet`
  String get you_didnt_reach {
    return Intl.message(
      'You did not reach to this level yet',
      name: 'you_didnt_reach',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Source of Digital Solutions`
  String get source_of_digital {
    return Intl.message(
      'Source of Digital Solutions',
      name: 'source_of_digital',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `contact us`
  String get contact_us {
    return Intl.message(
      'contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Registered user name/ Business name`
  String get registered_user_name {
    return Intl.message(
      'Registered user name/ Business name',
      name: 'registered_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Forgot username/ business name ?`
  String get forgot_username_business_name {
    return Intl.message(
      'Forgot username/ business name ?',
      name: 'forgot_username_business_name',
      desc: '',
      args: [],
    );
  }

  /// `Select which contact details should we use to reset your password`
  String get select_which_contact_details_should_we_use {
    return Intl.message(
      'Select which contact details should we use to reset your password',
      name: 'select_which_contact_details_should_we_use',
      desc: '',
      args: [],
    );
  }

  /// `Enter 6-digit recovery code`
  String get enter_code_digit {
    return Intl.message(
      'Enter 6-digit recovery code',
      name: 'enter_code_digit',
      desc: '',
      args: [],
    );
  }

  /// `The recovery code was sent to your mobile number. Please enter the code`
  String get send_code_success_phone {
    return Intl.message(
      'The recovery code was sent to your mobile number. Please enter the code',
      name: 'send_code_success_phone',
      desc: '',
      args: [],
    );
  }

  /// `The recovery code was sent to Email. Please enter the code`
  String get send_code_success_email {
    return Intl.message(
      'The recovery code was sent to Email. Please enter the code',
      name: 'send_code_success_email',
      desc: '',
      args: [],
    );
  }

  /// `Not Received`
  String get not_received {
    return Intl.message(
      'Not Received',
      name: 'not_received',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resend_OTP {
    return Intl.message(
      'Resend OTP',
      name: 'resend_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get password_reset_successful {
    return Intl.message(
      'Password reset successful',
      name: 'password_reset_successful',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully reset your password. Please use your new password when logging in.`
  String get password_message_success {
    return Intl.message(
      'You have successfully reset your password. Please use your new password when logging in.',
      name: 'password_message_success',
      desc: '',
      args: [],
    );
  }

  /// `VERIFY`
  String get verify {
    return Intl.message(
      'VERIFY',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `via SMS`
  String get via_SMS {
    return Intl.message(
      'via SMS',
      name: 'via_SMS',
      desc: '',
      args: [],
    );
  }

  /// `via E-mail`
  String get via_email {
    return Intl.message(
      'via E-mail',
      name: 'via_email',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_nav {
    return Intl.message(
      'Profile',
      name: 'profile_nav',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your location`
  String get please_enter_location {
    return Intl.message(
      'Please enter your location',
      name: 'please_enter_location',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get please_enter_phone {
    return Intl.message(
      'Please enter your phone number',
      name: 'please_enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Request Maintenance`
  String get request_maintenance {
    return Intl.message(
      'Request Maintenance',
      name: 'request_maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Selected Video`
  String get selected_video {
    return Intl.message(
      'Selected Video',
      name: 'selected_video',
      desc: '',
      args: [],
    );
  }

  /// `Selected Image`
  String get selected_image {
    return Intl.message(
      'Selected Image',
      name: 'selected_image',
      desc: '',
      args: [],
    );
  }

  /// `Upload the Files here`
  String get upload_the_files_here {
    return Intl.message(
      'Upload the Files here',
      name: 'upload_the_files_here',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get change_language {
    return Intl.message(
      'Change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Select currencies to use`
  String get select_currencies_to_use {
    return Intl.message(
      'Select currencies to use',
      name: 'select_currencies_to_use',
      desc: '',
      args: [],
    );
  }

  /// `Change currency`
  String get change_currency {
    return Intl.message(
      'Change currency',
      name: 'change_currency',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Common`
  String get common {
    return Intl.message(
      'Common',
      name: 'common',
      desc: '',
      args: [],
    );
  }

  /// `Products you have`
  String get products_you_have {
    return Intl.message(
      'Products you have',
      name: 'products_you_have',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Special For You`
  String get special_for_you {
    return Intl.message(
      'Special For You',
      name: 'special_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Model number`
  String get model_number {
    return Intl.message(
      'Model number',
      name: 'model_number',
      desc: '',
      args: [],
    );
  }

  /// `Serial no`
  String get serial_no {
    return Intl.message(
      'Serial no',
      name: 'serial_no',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Profile information`
  String get profile_information {
    return Intl.message(
      'Profile information',
      name: 'profile_information',
      desc: '',
      args: [],
    );
  }

  /// `Show all order`
  String get show_all_order {
    return Intl.message(
      'Show all order',
      name: 'show_all_order',
      desc: '',
      args: [],
    );
  }

  /// `QAR`
  String get qar {
    return Intl.message(
      'QAR',
      name: 'qar',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `General Data`
  String get general_data {
    return Intl.message(
      'General Data',
      name: 'general_data',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Description & Maintenance`
  String get description_maintenance {
    return Intl.message(
      'Description & Maintenance',
      name: 'description_maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Purchased date`
  String get purchased_date {
    return Intl.message(
      'Purchased date',
      name: 'purchased_date',
      desc: '',
      args: [],
    );
  }

  /// `Installation date`
  String get installation_date {
    return Intl.message(
      'Installation date',
      name: 'installation_date',
      desc: '',
      args: [],
    );
  }

  /// `Technician man`
  String get technical_man {
    return Intl.message(
      'Technician man',
      name: 'technical_man',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get n_a {
    return Intl.message(
      'N/A',
      name: 'n_a',
      desc: '',
      args: [],
    );
  }

  /// `Order data`
  String get order_data {
    return Intl.message(
      'Order data',
      name: 'order_data',
      desc: '',
      args: [],
    );
  }

  /// `Ordered at`
  String get ordered_at {
    return Intl.message(
      'Ordered at',
      name: 'ordered_at',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Status`
  String get delivery_statuse {
    return Intl.message(
      'Delivery Status',
      name: 'delivery_statuse',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get payment_statuse {
    return Intl.message(
      'Payment Status',
      name: 'payment_statuse',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get created_at {
    return Intl.message(
      'Created at',
      name: 'created_at',
      desc: '',
      args: [],
    );
  }

  /// `You have to order one item at least`
  String get you_have_order_one_item {
    return Intl.message(
      'You have to order one item at least',
      name: 'you_have_order_one_item',
      desc: '',
      args: [],
    );
  }

  /// `Your cart`
  String get your_cart {
    return Intl.message(
      'Your cart',
      name: 'your_cart',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get add_new_address {
    return Intl.message(
      'Add new address',
      name: 'add_new_address',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summary`
  String get payment_summary {
    return Intl.message(
      'Payment Summary',
      name: 'payment_summary',
      desc: '',
      args: [],
    );
  }

  /// `Products price`
  String get products_price {
    return Intl.message(
      'Products price',
      name: 'products_price',
      desc: '',
      args: [],
    );
  }

  /// `Shipping coast`
  String get shipping_coast {
    return Intl.message(
      'Shipping coast',
      name: 'shipping_coast',
      desc: '',
      args: [],
    );
  }

  /// `Total Payment`
  String get total_payment {
    return Intl.message(
      'Total Payment',
      name: 'total_payment',
      desc: '',
      args: [],
    );
  }

  /// `Credit/Debit`
  String get credit_debit {
    return Intl.message(
      'Credit/Debit',
      name: 'credit_debit',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash_on_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Address Info`
  String get address_info {
    return Intl.message(
      'Address Info',
      name: 'address_info',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get add_address {
    return Intl.message(
      'Add Address',
      name: 'add_address',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Your Country`
  String get your_country {
    return Intl.message(
      'Your Country',
      name: 'your_country',
      desc: '',
      args: [],
    );
  }

  /// `Your City`
  String get your_city {
    return Intl.message(
      'Your City',
      name: 'your_city',
      desc: '',
      args: [],
    );
  }

  /// `Please select your city`
  String get please_select_your_city {
    return Intl.message(
      'Please select your city',
      name: 'please_select_your_city',
      desc: '',
      args: [],
    );
  }

  /// `You have to select country first`
  String get you_have_select_country_first {
    return Intl.message(
      'You have to select country first',
      name: 'you_have_select_country_first',
      desc: '',
      args: [],
    );
  }

  /// `Create address`
  String get create_address {
    return Intl.message(
      'Create address',
      name: 'create_address',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Please press refresh button`
  String get please_press_refresh_button {
    return Intl.message(
      'Please press refresh button',
      name: 'please_press_refresh_button',
      desc: '',
      args: [],
    );
  }

  /// `You region`
  String get your_region {
    return Intl.message(
      'You region',
      name: 'your_region',
      desc: '',
      args: [],
    );
  }

  /// `Select your region`
  String get select_your_region {
    return Intl.message(
      'Select your region',
      name: 'select_your_region',
      desc: '',
      args: [],
    );
  }

  /// `Show all request`
  String get show_all_request {
    return Intl.message(
      'Show all request',
      name: 'show_all_request',
      desc: '',
      args: [],
    );
  }

  /// `You can see all your maintenance request`
  String get you_can_see_all_your_maintenance_request {
    return Intl.message(
      'You can see all your maintenance request',
      name: 'you_can_see_all_your_maintenance_request',
      desc: '',
      args: [],
    );
  }

  /// `Edit Image`
  String get edit_image {
    return Intl.message(
      'Edit Image',
      name: 'edit_image',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Select image`
  String get select_image {
    return Intl.message(
      'Select image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Country code`
  String get country_code {
    return Intl.message(
      'Country code',
      name: 'country_code',
      desc: '',
      args: [],
    );
  }

  /// `Type Description here`
  String get type_description_here {
    return Intl.message(
      'Type Description here',
      name: 'type_description_here',
      desc: '',
      args: [],
    );
  }

  /// `Enter your description here`
  String get enter_your_description_here {
    return Intl.message(
      'Enter your description here',
      name: 'enter_your_description_here',
      desc: '',
      args: [],
    );
  }

  /// `Select machine`
  String get select_machine {
    return Intl.message(
      'Select machine',
      name: 'select_machine',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Performance`
  String get performance {
    return Intl.message(
      'Performance',
      name: 'performance',
      desc: '',
      args: [],
    );
  }

  /// `Contact list`
  String get contact_list {
    return Intl.message(
      'Contact list',
      name: 'contact_list',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Add Contact`
  String get add_contact {
    return Intl.message(
      'Add Contact',
      name: 'add_contact',
      desc: '',
      args: [],
    );
  }

  /// `Edit Contact`
  String get edit_contact {
    return Intl.message(
      'Edit Contact',
      name: 'edit_contact',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and policy`
  String get privacy_and_policy {
    return Intl.message(
      'Privacy and policy',
      name: 'privacy_and_policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `My Booking`
  String get my_booking {
    return Intl.message(
      'My Booking',
      name: 'my_booking',
      desc: '',
      args: [],
    );
  }

  /// `Search about user`
  String get search_about_user {
    return Intl.message(
      'Search about user',
      name: 'search_about_user',
      desc: '',
      args: [],
    );
  }

  /// `Flights`
  String get flights {
    return Intl.message(
      'Flights',
      name: 'flights',
      desc: '',
      args: [],
    );
  }

  /// `Clear all`
  String get clear_all {
    return Intl.message(
      'Clear all',
      name: 'clear_all',
      desc: '',
      args: [],
    );
  }

  /// `Total item`
  String get total_item {
    return Intl.message(
      'Total item',
      name: 'total_item',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summery`
  String get payment_summery {
    return Intl.message(
      'Payment Summery',
      name: 'payment_summery',
      desc: '',
      args: [],
    );
  }

  /// `Available Sizes`
  String get available_sizes {
    return Intl.message(
      'Available Sizes',
      name: 'available_sizes',
      desc: '',
      args: [],
    );
  }

  /// `Available Colors`
  String get available_colors {
    return Intl.message(
      'Available Colors',
      name: 'available_colors',
      desc: '',
      args: [],
    );
  }

  /// `Colors`
  String get colors {
    return Intl.message(
      'Colors',
      name: 'colors',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Clear Wishlist`
  String get clear_wishlist {
    return Intl.message(
      'Clear Wishlist',
      name: 'clear_wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Wallet amount`
  String get wallet_amount {
    return Intl.message(
      'Wallet amount',
      name: 'wallet_amount',
      desc: '',
      args: [],
    );
  }

  /// `Points amount`
  String get points_amount {
    return Intl.message(
      'Points amount',
      name: 'points_amount',
      desc: '',
      args: [],
    );
  }

  /// `Addresses`
  String get my_address {
    return Intl.message(
      'Addresses',
      name: 'my_address',
      desc: '',
      args: [],
    );
  }

  /// `My Order`
  String get my_order {
    return Intl.message(
      'My Order',
      name: 'my_order',
      desc: '',
      args: [],
    );
  }

  /// `Unknown City`
  String get unknown_city {
    return Intl.message(
      'Unknown City',
      name: 'unknown_city',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Country`
  String get unknown_country {
    return Intl.message(
      'Unknown Country',
      name: 'unknown_country',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load addresses`
  String get failed_to_load_addresses {
    return Intl.message(
      'Failed to load addresses',
      name: 'failed_to_load_addresses',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have any addresses saved yet.\nAdd one now to make your checkout process smoother!`
  String get address_message {
    return Intl.message(
      'You don’t have any addresses saved yet.\nAdd one now to make your checkout process smoother!',
      name: 'address_message',
      desc: '',
      args: [],
    );
  }

  /// `Select Country and City`
  String get select_country_and_city {
    return Intl.message(
      'Select Country and City',
      name: 'select_country_and_city',
      desc: '',
      args: [],
    );
  }

  /// `Please select a city`
  String get please_select_a_city {
    return Intl.message(
      'Please select a city',
      name: 'please_select_a_city',
      desc: '',
      args: [],
    );
  }

  /// `No Country Available`
  String get no_country_available {
    return Intl.message(
      'No Country Available',
      name: 'no_country_available',
      desc: '',
      args: [],
    );
  }

  /// `No City Available`
  String get no_city_available {
    return Intl.message(
      'No City Available',
      name: 'no_city_available',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get select_country {
    return Intl.message(
      'Select Country',
      name: 'select_country',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get select_city {
    return Intl.message(
      'Select City',
      name: 'select_city',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get select_address {
    return Intl.message(
      'Select Address',
      name: 'select_address',
      desc: '',
      args: [],
    );
  }

  /// `Search Country`
  String get search_country {
    return Intl.message(
      'Search Country',
      name: 'search_country',
      desc: '',
      args: [],
    );
  }

  /// `Search City`
  String get search_city {
    return Intl.message(
      'Search City',
      name: 'search_city',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Country`
  String get failed_to_load_country {
    return Intl.message(
      'Failed to load Country',
      name: 'failed_to_load_country',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load City`
  String get failed_to_load_City {
    return Intl.message(
      'Failed to load City',
      name: 'failed_to_load_City',
      desc: '',
      args: [],
    );
  }

  /// `Please select your country`
  String get please_select_your_country {
    return Intl.message(
      'Please select your country',
      name: 'please_select_your_country',
      desc: '',
      args: [],
    );
  }

  /// `No Country selected \n please select a Country first`
  String get info_dialog_address {
    return Intl.message(
      'No Country selected \n please select a Country first',
      name: 'info_dialog_address',
      desc: '',
      args: [],
    );
  }

  /// `Your wallet is empty`
  String get your_wallet_is_empty {
    return Intl.message(
      'Your wallet is empty',
      name: 'your_wallet_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get all_products {
    return Intl.message(
      'All Products',
      name: 'all_products',
      desc: '',
      args: [],
    );
  }

  /// `All Packages`
  String get all_packages {
    return Intl.message(
      'All Packages',
      name: 'all_packages',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while the data loads from the server.`
  String get please_wait_while_the_data_loads_from_the_server {
    return Intl.message(
      'Please wait while the data loads from the server.',
      name: 'please_wait_while_the_data_loads_from_the_server',
      desc: '',
      args: [],
    );
  }

  /// `Verify Checkout`
  String get verify_checkout {
    return Intl.message(
      'Verify Checkout',
      name: 'verify_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Address details`
  String get address_details {
    return Intl.message(
      'Address details',
      name: 'address_details',
      desc: '',
      args: [],
    );
  }

  /// `Address created successfully`
  String get address_created_successfully {
    return Intl.message(
      'Address created successfully',
      name: 'address_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create address`
  String get failed_to_create_address {
    return Intl.message(
      'Failed to create address',
      name: 'failed_to_create_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get enter_address {
    return Intl.message(
      'Enter Address',
      name: 'enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter Street`
  String get enter_street {
    return Intl.message(
      'Enter Street',
      name: 'enter_street',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get postal_code {
    return Intl.message(
      'Postal code',
      name: 'postal_code',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get flat {
    return Intl.message(
      'Flat',
      name: 'flat',
      desc: '',
      args: [],
    );
  }

  /// `Villa`
  String get villa {
    return Intl.message(
      'Villa',
      name: 'villa',
      desc: '',
      args: [],
    );
  }

  /// `Flat Number`
  String get flat_number {
    return Intl.message(
      'Flat Number',
      name: 'flat_number',
      desc: '',
      args: [],
    );
  }

  /// `Villa Number`
  String get villa_number {
    return Intl.message(
      'Villa Number',
      name: 'villa_number',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all required fields`
  String get please_fill_all_required_fields {
    return Intl.message(
      'Please fill all required fields',
      name: 'please_fill_all_required_fields',
      desc: '',
      args: [],
    );
  }

  /// `Done Successfully please check your cart`
  String get done_successfully_check_your_cart {
    return Intl.message(
      'Done Successfully please check your cart',
      name: 'done_successfully_check_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `You will get`
  String get you_will_get {
    return Intl.message(
      'You will get',
      name: 'you_will_get',
      desc: '',
      args: [],
    );
  }

  /// `points if you buy this product`
  String get points_if_you_buy_this_product {
    return Intl.message(
      'points if you buy this product',
      name: 'points_if_you_buy_this_product',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign in with`
  String get or_sign_in_with {
    return Intl.message(
      'Or Sign in with',
      name: 'or_sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `Enter the password again`
  String get enter_the_password_again {
    return Intl.message(
      'Enter the password again',
      name: 'enter_the_password_again',
      desc: '',
      args: [],
    );
  }

  /// `We will verify your account`
  String get we_will_verify_your_account {
    return Intl.message(
      'We will verify your account',
      name: 'we_will_verify_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Are you ready?`
  String get are_you_ready {
    return Intl.message(
      'Are you ready?',
      name: 'are_you_ready',
      desc: '',
      args: [],
    );
  }

  /// `Verify Account`
  String get verify_account {
    return Intl.message(
      'Verify Account',
      name: 'verify_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get please_enter_the_password_again {
    return Intl.message(
      'Please enter the password again',
      name: 'please_enter_the_password_again',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for confirming your account`
  String get thank_you_for_confirming_your_account {
    return Intl.message(
      'Thank you for confirming your account',
      name: 'thank_you_for_confirming_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verify_code {
    return Intl.message(
      'Verify Code',
      name: 'verify_code',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a verification code to your email. Please enter the code to confirm your account`
  String get otp_send_email {
    return Intl.message(
      'We have sent a verification code to your email. Please enter the code to confirm your account',
      name: 'otp_send_email',
      desc: '',
      args: [],
    );
  }

  /// `I didn't receive the message`
  String get do_not_receive_the_message {
    return Intl.message(
      'I didn\'t receive the message',
      name: 'do_not_receive_the_message',
      desc: '',
      args: [],
    );
  }

  /// `Your email is`
  String get your_email_is {
    return Intl.message(
      'Your email is',
      name: 'your_email_is',
      desc: '',
      args: [],
    );
  }

  /// `Your sent code to this email`
  String get your_sent_code_to_this_email {
    return Intl.message(
      'Your sent code to this email',
      name: 'your_sent_code_to_this_email',
      desc: '',
      args: [],
    );
  }

  /// `Set Profile Details`
  String get set_profile_details {
    return Intl.message(
      'Set Profile Details',
      name: 'set_profile_details',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to News`
  String get subscribe_to_news {
    return Intl.message(
      'Subscribe to News',
      name: 'subscribe_to_news',
      desc: '',
      args: [],
    );
  }

  /// `View our latest products and latest news`
  String get view_our_latest_products_and_latest_news {
    return Intl.message(
      'View our latest products and latest news',
      name: 'view_our_latest_products_and_latest_news',
      desc: '',
      args: [],
    );
  }

  /// `Upload Profile Picture`
  String get upload_profile_picture {
    return Intl.message(
      'Upload Profile Picture',
      name: 'upload_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `No image was selected.`
  String get no_image_was_selected {
    return Intl.message(
      'No image was selected.',
      name: 'no_image_was_selected',
      desc: '',
      args: [],
    );
  }

  /// `Select Profile Picture`
  String get select_profile_picture {
    return Intl.message(
      'Select Profile Picture',
      name: 'select_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email so you can continue resetting your password`
  String
      get please_enter_your_email_so_you_can_continue_resetting_your_password {
    return Intl.message(
      'Please enter your email so you can continue resetting your password',
      name:
          'please_enter_your_email_so_you_can_continue_resetting_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account ?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account ?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Choose one Gift`
  String get choose_one_gift {
    return Intl.message(
      'Choose one Gift',
      name: 'choose_one_gift',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Select your gift`
  String get select_your_gift {
    return Intl.message(
      'Select your gift',
      name: 'select_your_gift',
      desc: '',
      args: [],
    );
  }

  /// `frequently asked questions`
  String get faqdesc {
    return Intl.message(
      'frequently asked questions',
      name: 'faqdesc',
      desc: '',
      args: [],
    );
  }

  /// `No trips available.`
  String get no_trips_available {
    return Intl.message(
      'No trips available.',
      name: 'no_trips_available',
      desc: '',
      args: [],
    );
  }

  /// `No faq available`
  String get no_faq_available {
    return Intl.message(
      'No faq available',
      name: 'no_faq_available',
      desc: '',
      args: [],
    );
  }

  /// `seats booked`
  String get seats_booked {
    return Intl.message(
      'seats booked',
      name: 'seats_booked',
      desc: '',
      args: [],
    );
  }

  /// `Where do you want go?`
  String get where_do_you_want_go {
    return Intl.message(
      'Where do you want go?',
      name: 'where_do_you_want_go',
      desc: '',
      args: [],
    );
  }

  /// `Customization`
  String get customization {
    return Intl.message(
      'Customization',
      name: 'customization',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get book_now {
    return Intl.message(
      'Book now',
      name: 'book_now',
      desc: '',
      args: [],
    );
  }

  /// `Customization options`
  String get customization_options {
    return Intl.message(
      'Customization options',
      name: 'customization_options',
      desc: '',
      args: [],
    );
  }

  /// `Book hotel`
  String get book_hotel {
    return Intl.message(
      'Book hotel',
      name: 'book_hotel',
      desc: '',
      args: [],
    );
  }

  /// `Book restaurant`
  String get book_restaurant {
    return Intl.message(
      'Book restaurant',
      name: 'book_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Hotels`
  String get hotels {
    return Intl.message(
      'Hotels',
      name: 'hotels',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants`
  String get restaurants {
    return Intl.message(
      'Restaurants',
      name: 'restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Search Hotel`
  String get search_hotel {
    return Intl.message(
      'Search Hotel',
      name: 'search_hotel',
      desc: '',
      args: [],
    );
  }

  /// `No Resturant Available`
  String get no_resturant_available {
    return Intl.message(
      'No Resturant Available',
      name: 'no_resturant_available',
      desc: '',
      args: [],
    );
  }

  /// `Select cuisine`
  String get select_cuisine {
    return Intl.message(
      'Select cuisine',
      name: 'select_cuisine',
      desc: '',
      args: [],
    );
  }

  /// `Please enter at least one word.`
  String get please_enter_at_least_one_word {
    return Intl.message(
      'Please enter at least one word.',
      name: 'please_enter_at_least_one_word',
      desc: '',
      args: [],
    );
  }

  /// `Travel costs`
  String get travel_costs {
    return Intl.message(
      'Travel costs',
      name: 'travel_costs',
      desc: '',
      args: [],
    );
  }

  /// `One way cost`
  String get one_way_cost {
    return Intl.message(
      'One way cost',
      name: 'one_way_cost',
      desc: '',
      args: [],
    );
  }

  /// `Round trip cost`
  String get two_way_cost {
    return Intl.message(
      'Round trip cost',
      name: 'two_way_cost',
      desc: '',
      args: [],
    );
  }

  /// `Arrival City`
  String get arrival_city {
    return Intl.message(
      'Arrival City',
      name: 'arrival_city',
      desc: '',
      args: [],
    );
  }

  /// `Departure City`
  String get departure_city {
    return Intl.message(
      'Departure City',
      name: 'departure_city',
      desc: '',
      args: [],
    );
  }

  /// `Departure Date`
  String get departure_date {
    return Intl.message(
      'Departure Date',
      name: 'departure_date',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Date`
  String get arrival_date {
    return Intl.message(
      'Arrival Date',
      name: 'arrival_date',
      desc: '',
      args: [],
    );
  }

  /// `Number of Guests`
  String get number_of_guests {
    return Intl.message(
      'Number of Guests',
      name: 'number_of_guests',
      desc: '',
      args: [],
    );
  }

  /// `The flight is not valid for booking.`
  String get the_flight_is_not_valid_for_booking {
    return Intl.message(
      'The flight is not valid for booking.',
      name: 'the_flight_is_not_valid_for_booking',
      desc: '',
      args: [],
    );
  }

  /// `We are booking successfully!`
  String get we_are_booking_successfully {
    return Intl.message(
      'We are booking successfully!',
      name: 'we_are_booking_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Select trip type`
  String get select_trip_type {
    return Intl.message(
      'Select trip type',
      name: 'select_trip_type',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message(
      'Individual',
      name: 'individual',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Please select trip type!`
  String get please_select_trip_type {
    return Intl.message(
      'Please select trip type!',
      name: 'please_select_trip_type',
      desc: '',
      args: [],
    );
  }

  /// `Cuisine`
  String get cuisine {
    return Intl.message(
      'Cuisine',
      name: 'cuisine',
      desc: '',
      args: [],
    );
  }

  /// `Reserve Now`
  String get reserve_now {
    return Intl.message(
      'Reserve Now',
      name: 'reserve_now',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your purchase. Your payment has been successfully processed.\nYou can find your reservition details in the Booking Tap.`
  String get success_pay_message {
    return Intl.message(
      'Thank you for your purchase. Your payment has been successfully processed.\nYou can find your reservition details in the Booking Tap.',
      name: 'success_pay_message',
      desc: '',
      args: [],
    );
  }

  /// `Reservation Details`
  String get reservation_details {
    return Intl.message(
      'Reservation Details',
      name: 'reservation_details',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get departure {
    return Intl.message(
      'Departure',
      name: 'departure',
      desc: '',
      args: [],
    );
  }

  /// `Trip Type`
  String get trip_type {
    return Intl.message(
      'Trip Type',
      name: 'trip_type',
      desc: '',
      args: [],
    );
  }

  /// `Booking Type`
  String get booking_type {
    return Intl.message(
      'Booking Type',
      name: 'booking_type',
      desc: '',
      args: [],
    );
  }

  /// `Hotel Details`
  String get hotel_details {
    return Intl.message(
      'Hotel Details',
      name: 'hotel_details',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Details`
  String get restaurant_details {
    return Intl.message(
      'Restaurant Details',
      name: 'restaurant_details',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Payment`
  String get proceed_to_payment {
    return Intl.message(
      'Proceed to Payment',
      name: 'proceed_to_payment',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get select_payment_method {
    return Intl.message(
      'Select Payment Method',
      name: 'select_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Please select a payment method.`
  String get please_select_a_payment_method {
    return Intl.message(
      'Please select a payment method.',
      name: 'please_select_a_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `My Reservations`
  String get my_reservations {
    return Intl.message(
      'My Reservations',
      name: 'my_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is currently empty.\nBrowse our products and add your favorites to get started!`
  String get cart_message {
    return Intl.message(
      'Your cart is currently empty.\nBrowse our products and add your favorites to get started!',
      name: 'cart_message',
      desc: '',
      args: [],
    );
  }

  /// `Looks like your wish list is empty.\nTime to fill it up with some fabulous finds`
  String get favorite_screen {
    return Intl.message(
      'Looks like your wish list is empty.\nTime to fill it up with some fabulous finds',
      name: 'favorite_screen',
      desc: '',
      args: [],
    );
  }

  /// `Delete all wishlist items`
  String get delete_all_wishlist_items {
    return Intl.message(
      'Delete all wishlist items',
      name: 'delete_all_wishlist_items',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load favorites`
  String get failed_to_load_favorites {
    return Intl.message(
      'Failed to load favorites',
      name: 'failed_to_load_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Popular Categories`
  String get popular_categories {
    return Intl.message(
      'Popular Categories',
      name: 'popular_categories',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Tax coast`
  String get tax_coast {
    return Intl.message(
      'Tax coast',
      name: 'tax_coast',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Add Coupon`
  String get add_coupon {
    return Intl.message(
      'Add Coupon',
      name: 'add_coupon',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Only`
  String get only {
    return Intl.message(
      'Only',
      name: 'only',
      desc: '',
      args: [],
    );
  }

  /// `left in stock, order now.`
  String get left_in_stock_order_now {
    return Intl.message(
      'left in stock, order now.',
      name: 'left_in_stock_order_now',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email or password.`
  String get please_check_your_email_or_password {
    return Intl.message(
      'Please check your email or password.',
      name: 'please_check_your_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this address?`
  String get do_you_want_to_delete_this_address {
    return Intl.message(
      'Do you want to delete this address?',
      name: 'do_you_want_to_delete_this_address',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete Address`
  String get delete_address {
    return Intl.message(
      'Delete Address',
      name: 'delete_address',
      desc: '',
      args: [],
    );
  }

  /// `No Order Found`
  String get no_order_found {
    return Intl.message(
      'No Order Found',
      name: 'no_order_found',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Points Earned`
  String get points_earned {
    return Intl.message(
      'Points Earned',
      name: 'points_earned',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Cost`
  String get shipping_cost {
    return Intl.message(
      'Shipping Cost',
      name: 'shipping_cost',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Gift Details`
  String get gift_details {
    return Intl.message(
      'Gift Details',
      name: 'gift_details',
      desc: '',
      args: [],
    );
  }

  /// `Gift Name`
  String get gift_name {
    return Intl.message(
      'Gift Name',
      name: 'gift_name',
      desc: '',
      args: [],
    );
  }

  /// `Gift Category`
  String get gift_category {
    return Intl.message(
      'Gift Category',
      name: 'gift_category',
      desc: '',
      args: [],
    );
  }

  /// `Gift Price`
  String get gift_price {
    return Intl.message(
      'Gift Price',
      name: 'gift_price',
      desc: '',
      args: [],
    );
  }

  /// `Success, please check your cart`
  String get success_please_check_your_cart {
    return Intl.message(
      'Success, please check your cart',
      name: 'success_please_check_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `You have add more products over than Stock`
  String get you_have_add_more_products_over_than_stock {
    return Intl.message(
      'You have add more products over than Stock',
      name: 'you_have_add_more_products_over_than_stock',
      desc: '',
      args: [],
    );
  }

  /// `You have to order one item at least`
  String get you_have_to_order_one_item_at_least {
    return Intl.message(
      'You have to order one item at least',
      name: 'you_have_to_order_one_item_at_least',
      desc: '',
      args: [],
    );
  }

  /// `Related Product`
  String get related_product {
    return Intl.message(
      'Related Product',
      name: 'related_product',
      desc: '',
      args: [],
    );
  }

  /// `New In`
  String get new_in {
    return Intl.message(
      'New In',
      name: 'new_in',
      desc: '',
      args: [],
    );
  }

  /// `On Sale`
  String get on_sale {
    return Intl.message(
      'On Sale',
      name: 'on_sale',
      desc: '',
      args: [],
    );
  }

  /// `Featured Products`
  String get featured_products {
    return Intl.message(
      'Featured Products',
      name: 'featured_products',
      desc: '',
      args: [],
    );
  }

  /// `Notify me`
  String get notify_me {
    return Intl.message(
      'Notify me',
      name: 'notify_me',
      desc: '',
      args: [],
    );
  }

  /// `Notify request has been sent successfully`
  String get notify_request_has_been_sent_successfully {
    return Intl.message(
      'Notify request has been sent successfully',
      name: 'notify_request_has_been_sent_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Reorder`
  String get reorder {
    return Intl.message(
      'Reorder',
      name: 'reorder',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to logout?`
  String get do_you_really_want_to_log_out {
    return Intl.message(
      'Do you really want to logout?',
      name: 'do_you_really_want_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `View all reviews`
  String get view_all_reviews {
    return Intl.message(
      'View all reviews',
      name: 'view_all_reviews',
      desc: '',
      args: [],
    );
  }

  /// `There are no categories yet.\n Please try again later.`
  String get there_are_no_categories_yet_please_try_again_later {
    return Intl.message(
      'There are no categories yet.\n Please try again later.',
      name: 'there_are_no_categories_yet_please_try_again_later',
      desc: '',
      args: [],
    );
  }

  /// `Please check your OTP code`
  String get please_check_your_OTP_code {
    return Intl.message(
      'Please check your OTP code',
      name: 'please_check_your_OTP_code',
      desc: '',
      args: [],
    );
  }

  /// `The address is required`
  String get the_address_is_required {
    return Intl.message(
      'The address is required',
      name: 'the_address_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get tag {
    return Intl.message(
      'Tag',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your feedback! We appreciate your support.`
  String get review_message {
    return Intl.message(
      'Thank you for your feedback! We appreciate your support.',
      name: 'review_message',
      desc: '',
      args: [],
    );
  }

  /// `We"d love to hear your thoughts! Please rate and review our product.`
  String get review_hint {
    return Intl.message(
      'We"d love to hear your thoughts! Please rate and review our product.',
      name: 'review_hint',
      desc: '',
      args: [],
    );
  }

  /// `You have already rated it.`
  String get you_have_already_rated_it {
    return Intl.message(
      'You have already rated it.',
      name: 'you_have_already_rated_it',
      desc: '',
      args: [],
    );
  }

  /// `You will earn points if you upload a photo.`
  String get you_will_earn_points_if_you_upload_a_photo {
    return Intl.message(
      'You will earn points if you upload a photo.',
      name: 'you_will_earn_points_if_you_upload_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `You have to enter comment`
  String get you_have_to_enter_comment {
    return Intl.message(
      'You have to enter comment',
      name: 'you_have_to_enter_comment',
      desc: '',
      args: [],
    );
  }

  /// `Enter your comment`
  String get enter_your_comment {
    return Intl.message(
      'Enter your comment',
      name: 'enter_your_comment',
      desc: '',
      args: [],
    );
  }

  /// `All Reviews`
  String get all_reviews {
    return Intl.message(
      'All Reviews',
      name: 'all_reviews',
      desc: '',
      args: [],
    );
  }

  /// `read less`
  String get read_less {
    return Intl.message(
      'read less',
      name: 'read_less',
      desc: '',
      args: [],
    );
  }

  /// `No reviews are available for this product yet.`
  String get no_reviews_are_available_for_this_product_yet {
    return Intl.message(
      'No reviews are available for this product yet.',
      name: 'no_reviews_are_available_for_this_product_yet',
      desc: '',
      args: [],
    );
  }

  /// `Foloosi method is not available`
  String get foloosi_method_is_not_available {
    return Intl.message(
      'Foloosi method is not available',
      name: 'foloosi_method_is_not_available',
      desc: '',
      args: [],
    );
  }

  /// `No Product available Now \n Try again.`
  String get no_product_available {
    return Intl.message(
      'No Product available Now \n Try again.',
      name: 'no_product_available',
      desc: '',
      args: [],
    );
  }

  /// `Out of Bounds`
  String get out_of_bounds {
    return Intl.message(
      'Out of Bounds',
      name: 'out_of_bounds',
      desc: '',
      args: [],
    );
  }

  /// `Change City`
  String get change_city {
    return Intl.message(
      'Change City',
      name: 'change_city',
      desc: '',
      args: [],
    );
  }

  /// `The selected location is outside the allowed area. Would you like to change the city?`
  String get out_bound_area_message_ {
    return Intl.message(
      'The selected location is outside the allowed area. Would you like to change the city?',
      name: 'out_bound_area_message_',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your purchase. Your payment has been successfully processed.\nYou can find your order details in the Settings screen. Press the 'My Orders' button to view your orders.`
  String get success_checkout_message {
    return Intl.message(
      'Thank you for your purchase. Your payment has been successfully processed.\nYou can find your order details in the Settings screen. Press the \'My Orders\' button to view your orders.',
      name: 'success_checkout_message',
      desc: '',
      args: [],
    );
  }

  /// `Enter company details`
  String get enter_company_details {
    return Intl.message(
      'Enter company details',
      name: 'enter_company_details',
      desc: '',
      args: [],
    );
  }

  /// `Company name`
  String get company_name {
    return Intl.message(
      'Company name',
      name: 'company_name',
      desc: '',
      args: [],
    );
  }

  /// `Company website`
  String get company_website {
    return Intl.message(
      'Company website',
      name: 'company_website',
      desc: '',
      args: [],
    );
  }

  /// `Company contact details`
  String get company_contact_details {
    return Intl.message(
      'Company contact details',
      name: 'company_contact_details',
      desc: '',
      args: [],
    );
  }

  /// `Company email`
  String get company_email {
    return Intl.message(
      'Company email',
      name: 'company_email',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personal_information {
    return Intl.message(
      'Personal information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `Personal email`
  String get personal_email {
    return Intl.message(
      'Personal email',
      name: 'personal_email',
      desc: '',
      args: [],
    );
  }

  /// `Upload trade license`
  String get upload_trade_license {
    return Intl.message(
      'Upload trade license',
      name: 'upload_trade_license',
      desc: '',
      args: [],
    );
  }

  /// `Select trade license`
  String get select_trade_license {
    return Intl.message(
      'Select trade license',
      name: 'select_trade_license',
      desc: '',
      args: [],
    );
  }

  /// `Source of knowledge`
  String get source_of_knowledge {
    return Intl.message(
      'Source of knowledge',
      name: 'source_of_knowledge',
      desc: '',
      args: [],
    );
  }

  /// `Please specify`
  String get please_specify {
    return Intl.message(
      'Please specify',
      name: 'please_specify',
      desc: '',
      args: [],
    );
  }

  /// `Additional information`
  String get additional_information {
    return Intl.message(
      'Additional information',
      name: 'additional_information',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get terms_and_conditions {
    return Intl.message(
      'Terms and conditions',
      name: 'terms_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Agree terms`
  String get agree_terms {
    return Intl.message(
      'Agree terms',
      name: 'agree_terms',
      desc: '',
      args: [],
    );
  }

  /// `The current role is:`
  String get the_current_role_is {
    return Intl.message(
      'The current role is:',
      name: 'the_current_role_is',
      desc: '',
      args: [],
    );
  }

  /// `No FAQs available.`
  String get no_FAQs_available {
    return Intl.message(
      'No FAQs available.',
      name: 'no_FAQs_available',
      desc: '',
      args: [],
    );
  }

  /// `No Privacy and policy available.`
  String get no_privacy_and_policy_available {
    return Intl.message(
      'No Privacy and policy available.',
      name: 'no_privacy_and_policy_available',
      desc: '',
      args: [],
    );
  }

  /// `No Shipping Policy available.`
  String get no_shipping_policy_available {
    return Intl.message(
      'No Shipping Policy available.',
      name: 'no_shipping_policy_available',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Policy`
  String get shipping_policy {
    return Intl.message(
      'Shipping Policy',
      name: 'shipping_policy',
      desc: '',
      args: [],
    );
  }

  /// `Branches`
  String get branches {
    return Intl.message(
      'Branches',
      name: 'branches',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get location:`
  String get failed_to_get_location {
    return Intl.message(
      'Failed to get location:',
      name: 'failed_to_get_location',
      desc: '',
      args: [],
    );
  }

  /// `Here are our contact details:`
  String get here_are_our_contact_details {
    return Intl.message(
      'Here are our contact details:',
      name: 'here_are_our_contact_details',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Support Section`
  String get support_section {
    return Intl.message(
      'Support Section',
      name: 'support_section',
      desc: '',
      args: [],
    );
  }

  /// `Filter by:`
  String get filter_by {
    return Intl.message(
      'Filter by:',
      name: 'filter_by',
      desc: '',
      args: [],
    );
  }

  /// `Sort Options`
  String get sort_options {
    return Intl.message(
      'Sort Options',
      name: 'sort_options',
      desc: '',
      args: [],
    );
  }

  /// `Change Role`
  String get change_role {
    return Intl.message(
      'Change Role',
      name: 'change_role',
      desc: '',
      args: [],
    );
  }

  /// `Add business information`
  String get add_business_information {
    return Intl.message(
      'Add business information',
      name: 'add_business_information',
      desc: '',
      args: [],
    );
  }

  /// `Registration has been successful. You can log in now.`
  String get register_success_message {
    return Intl.message(
      'Registration has been successful. You can log in now.',
      name: 'register_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Please select a color and size first`
  String get please_select_a_color_and_size_first {
    return Intl.message(
      'Please select a color and size first',
      name: 'please_select_a_color_and_size_first',
      desc: '',
      args: [],
    );
  }

  /// `Stock doesn't have this amount`
  String get stock_does_have_this_amount {
    return Intl.message(
      'Stock doesn\'t have this amount',
      name: 'stock_does_have_this_amount',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully`
  String get product_added_successfully {
    return Intl.message(
      'Product added successfully',
      name: 'product_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the payment before selecting the gift and address.`
  String get please_verify_the_payment_before_selecting_the_gift_and_address {
    return Intl.message(
      'Please verify the payment before selecting the gift and address.',
      name: 'please_verify_the_payment_before_selecting_the_gift_and_address',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No notifications yet`
  String get oops_no_notifications_yet {
    return Intl.message(
      'Oops! No notifications yet',
      name: 'oops_no_notifications_yet',
      desc: '',
      args: [],
    );
  }

  /// `It seems that you've got a blank slate.\n We’ll let you know when updates arrive!`
  String get no_notification {
    return Intl.message(
      'It seems that you\'ve got a blank slate.\n We’ll let you know when updates arrive!',
      name: 'no_notification',
      desc: '',
      args: [],
    );
  }

  /// `The product was added successfully`
  String get the_product_added_successfully {
    return Intl.message(
      'The product was added successfully',
      name: 'the_product_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `View all products`
  String get view_all_products {
    return Intl.message(
      'View all products',
      name: 'view_all_products',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid phone number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid URL starting with http:// or https://`
  String get invalid_enter_url {
    return Intl.message(
      'Please enter a valid URL starting with http:// or https://',
      name: 'invalid_enter_url',
      desc: '',
      args: [],
    );
  }

  /// `The username must be at least 4 characters`
  String get invalid_username {
    return Intl.message(
      'The username must be at least 4 characters',
      name: 'invalid_username',
      desc: '',
      args: [],
    );
  }

  /// `Address must be 5 characters at least`
  String get invalid_address {
    return Intl.message(
      'Address must be 5 characters at least',
      name: 'invalid_address',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter a username`
  String get please_enter_a_username {
    return Intl.message(
      'Please Enter a username',
      name: 'please_enter_a_username',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter your first name`
  String get enter_your_first_name {
    return Intl.message(
      'Please Enter your first name',
      name: 'enter_your_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter your last name`
  String get enter_your_last_name {
    return Intl.message(
      'Please Enter your last name',
      name: 'enter_your_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter your Company name`
  String get enter_your_company_name {
    return Intl.message(
      'Please Enter your Company name',
      name: 'enter_your_company_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter your address`
  String get enter_your_address {
    return Intl.message(
      'Please Enter your address',
      name: 'enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Please fill required fields`
  String get please_fill_required_fields {
    return Intl.message(
      'Please fill required fields',
      name: 'please_fill_required_fields',
      desc: '',
      args: [],
    );
  }

  /// `No user data found`
  String get no_user_data_found {
    return Intl.message(
      'No user data found',
      name: 'no_user_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Done Successfully`
  String get done_successfully {
    return Intl.message(
      'Done Successfully',
      name: 'done_successfully',
      desc: '',
      args: [],
    );
  }

  /// `night`
  String get night {
    return Intl.message(
      'night',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `Set city`
  String get set_city {
    return Intl.message(
      'Set city',
      name: 'set_city',
      desc: '',
      args: [],
    );
  }

  /// `City set successfully!`
  String get city_set_successfully {
    return Intl.message(
      'City set successfully!',
      name: 'city_set_successfully',
      desc: '',
      args: [],
    );
  }

  /// `You haven't seized trips yet`
  String get you_haven_seized_trips_yet {
    return Intl.message(
      'You haven\'t seized trips yet',
      name: 'you_haven_seized_trips_yet',
      desc: '',
      args: [],
    );
  }

  /// `What service are you looking for?`
  String get what_service_are_you_looking_for {
    return Intl.message(
      'What service are you looking for?',
      name: 'what_service_are_you_looking_for',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter password`
  String get re_password {
    return Intl.message(
      'Re-Enter password',
      name: 're_password',
      desc: '',
      args: [],
    );
  }

  /// `select gender`
  String get select_gender {
    return Intl.message(
      'select gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `select birth date`
  String get select_birth_date {
    return Intl.message(
      'select birth date',
      name: 'select_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `My Boards`
  String get my_boards {
    return Intl.message(
      'My Boards',
      name: 'my_boards',
      desc: '',
      args: [],
    );
  }

  /// `Board Image`
  String get board_image {
    return Intl.message(
      'Board Image',
      name: 'board_image',
      desc: '',
      args: [],
    );
  }

  /// `Delete image`
  String get delete_image {
    return Intl.message(
      'Delete image',
      name: 'delete_image',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get add_image {
    return Intl.message(
      'Add image',
      name: 'add_image',
      desc: '',
      args: [],
    );
  }

  /// `Board Icon`
  String get board_icon {
    return Intl.message(
      'Board Icon',
      name: 'board_icon',
      desc: '',
      args: [],
    );
  }

  /// `Adding board`
  String get adding_board {
    return Intl.message(
      'Adding board',
      name: 'adding_board',
      desc: '',
      args: [],
    );
  }

  /// `Subpanels`
  String get subpanels {
    return Intl.message(
      'Subpanels',
      name: 'subpanels',
      desc: '',
      args: [],
    );
  }

  /// `Main board`
  String get main_board {
    return Intl.message(
      'Main board',
      name: 'main_board',
      desc: '',
      args: [],
    );
  }

  /// `Subpanel`
  String get subpanel {
    return Intl.message(
      'Subpanel',
      name: 'subpanel',
      desc: '',
      args: [],
    );
  }

  /// `There are no applications`
  String get there_are_no_applications {
    return Intl.message(
      'There are no applications',
      name: 'there_are_no_applications',
      desc: '',
      args: [],
    );
  }

  /// `Applications`
  String get applications {
    return Intl.message(
      'Applications',
      name: 'applications',
      desc: '',
      args: [],
    );
  }

  /// `Click on the app to add it to the board.`
  String get click_on_the_app_to_add_it_to_the_board {
    return Intl.message(
      'Click on the app to add it to the board.',
      name: 'click_on_the_app_to_add_it_to_the_board',
      desc: '',
      args: [],
    );
  }

  /// `Stop recording`
  String get stop_recording {
    return Intl.message(
      'Stop recording',
      name: 'stop_recording',
      desc: '',
      args: [],
    );
  }

  /// `Audio recording in progress`
  String get audio_recording_in_progress {
    return Intl.message(
      'Audio recording in progress',
      name: 'audio_recording_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Screen recording in progress`
  String get screen_recording_in_progress {
    return Intl.message(
      'Screen recording in progress',
      name: 'screen_recording_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Open file`
  String get open_file {
    return Intl.message(
      'Open file',
      name: 'open_file',
      desc: '',
      args: [],
    );
  }

  /// `Voice message`
  String get voice_message {
    return Intl.message(
      'Voice message',
      name: 'voice_message',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet`
  String get no_messages_yet {
    return Intl.message(
      'No messages yet',
      name: 'no_messages_yet',
      desc: '',
      args: [],
    );
  }

  /// `Screen recording stopped`
  String get screen_recording_stopped {
    return Intl.message(
      'Screen recording stopped',
      name: 'screen_recording_stopped',
      desc: '',
      args: [],
    );
  }

  /// `Screen recording started`
  String get screen_recording_started {
    return Intl.message(
      'Screen recording started',
      name: 'screen_recording_started',
      desc: '',
      args: [],
    );
  }

  /// `Attach file`
  String get attach_file {
    return Intl.message(
      'Attach file',
      name: 'attach_file',
      desc: '',
      args: [],
    );
  }

  /// `Record audio`
  String get record_audio {
    return Intl.message(
      'Record audio',
      name: 'record_audio',
      desc: '',
      args: [],
    );
  }

  /// `Record video`
  String get record_video {
    return Intl.message(
      'Record video',
      name: 'record_video',
      desc: '',
      args: [],
    );
  }

  /// `Record screen`
  String get record_screen {
    return Intl.message(
      'Record screen',
      name: 'record_screen',
      desc: '',
      args: [],
    );
  }

  /// `Write your message`
  String get write_your_message {
    return Intl.message(
      'Write your message',
      name: 'write_your_message',
      desc: '',
      args: [],
    );
  }

  /// `Share Link`
  String get share_link {
    return Intl.message(
      'Share Link',
      name: 'share_link',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Move`
  String get move {
    return Intl.message(
      'Move',
      name: 'move',
      desc: '',
      args: [],
    );
  }

  /// `Revision History`
  String get revision_history {
    return Intl.message(
      'Revision History',
      name: 'revision_history',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get shape {
    return Intl.message(
      'Style',
      name: 'shape',
      desc: '',
      args: [],
    );
  }

  /// `Default Language`
  String get default_language {
    return Intl.message(
      'Default Language',
      name: 'default_language',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `To-do list`
  String get to_do_list {
    return Intl.message(
      'To-do list',
      name: 'to_do_list',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `There are no sub-panels`
  String get there_are_no_sub_panels {
    return Intl.message(
      'There are no sub-panels',
      name: 'there_are_no_sub_panels',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get saving {
    return Intl.message(
      'Saving...',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Board settings`
  String get board_settings {
    return Intl.message(
      'Board settings',
      name: 'board_settings',
      desc: '',
      args: [],
    );
  }

  /// `Leaving`
  String get leaving {
    return Intl.message(
      'Leaving',
      name: 'leaving',
      desc: '',
      args: [],
    );
  }

  /// `Create a subboard`
  String get create_a_subboard {
    return Intl.message(
      'Create a subboard',
      name: 'create_a_subboard',
      desc: '',
      args: [],
    );
  }

  /// `Move the board`
  String get move_the_board {
    return Intl.message(
      'Move the board',
      name: 'move_the_board',
      desc: '',
      args: [],
    );
  }

  /// `Leave the board`
  String get leave_the_board {
    return Intl.message(
      'Leave the board',
      name: 'leave_the_board',
      desc: '',
      args: [],
    );
  }

  /// `Add your boards to favorites to see them here.`
  String get add_your_boards_to_favorites_to_see_them_here {
    return Intl.message(
      'Add your boards to favorites to see them here.',
      name: 'add_your_boards_to_favorites_to_see_them_here',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get birth_date {
    return Intl.message(
      'Birth date',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Crop Image`
  String get crop_image {
    return Intl.message(
      'Crop Image',
      name: 'crop_image',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color`
  String get pick_a_color {
    return Intl.message(
      'Pick a color',
      name: 'pick_a_color',
      desc: '',
      args: [],
    );
  }

  /// `Color picker`
  String get color_picker {
    return Intl.message(
      'Color picker',
      name: 'color_picker',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Only board users can view it.`
  String get only_board_users_can_view_it {
    return Intl.message(
      'Only board users can view it.',
      name: 'only_board_users_can_view_it',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Anyone with the link to the board can view it.`
  String get anyone_with_the_link_to_the_board_can_view_it {
    return Intl.message(
      'Anyone with the link to the board can view it.',
      name: 'anyone_with_the_link_to_the_board_can_view_it',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get add_user {
    return Intl.message(
      'Add User',
      name: 'add_user',
      desc: '',
      args: [],
    );
  }

  /// `Edit user`
  String get edit_user {
    return Intl.message(
      'Edit user',
      name: 'edit_user',
      desc: '',
      args: [],
    );
  }

  /// `Adding`
  String get adding {
    return Intl.message(
      'Adding',
      name: 'adding',
      desc: '',
      args: [],
    );
  }

  /// `Editing in progress`
  String get editing_in_progress {
    return Intl.message(
      'Editing in progress',
      name: 'editing_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get attachments {
    return Intl.message(
      'Attachments',
      name: 'attachments',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Daily report`
  String get daily_report {
    return Intl.message(
      'Daily report',
      name: 'daily_report',
      desc: '',
      args: [],
    );
  }

  /// `Enter report here`
  String get enter_report_here {
    return Intl.message(
      'Enter report here',
      name: 'enter_report_here',
      desc: '',
      args: [],
    );
  }

  /// `Write your report`
  String get write_your_report {
    return Intl.message(
      'Write your report',
      name: 'write_your_report',
      desc: '',
      args: [],
    );
  }

  /// `Submit report`
  String get submit_report {
    return Intl.message(
      'Submit report',
      name: 'submit_report',
      desc: '',
      args: [],
    );
  }

  /// `Add new task`
  String get add_new_task {
    return Intl.message(
      'Add new task',
      name: 'add_new_task',
      desc: '',
      args: [],
    );
  }

  /// `New task is being added`
  String get new_task_is_being_added {
    return Intl.message(
      'New task is being added',
      name: 'new_task_is_being_added',
      desc: '',
      args: [],
    );
  }

  /// `There are no tasks yet.`
  String get there_are_no_tasks_yet {
    return Intl.message(
      'There are no tasks yet.',
      name: 'there_are_no_tasks_yet',
      desc: '',
      args: [],
    );
  }

  /// `There are no documents yet.`
  String get there_are_no_documents_yet {
    return Intl.message(
      'There are no documents yet.',
      name: 'there_are_no_documents_yet',
      desc: '',
      args: [],
    );
  }

  /// `He has all the powers, such as adding and deleting applications and modifying settings, as well as controlling other members, including the administrator who founded the board.`
  String get admin_desc {
    return Intl.message(
      'He has all the powers, such as adding and deleting applications and modifying settings, as well as controlling other members, including the administrator who founded the board.',
      name: 'admin_desc',
      desc: '',
      args: [],
    );
  }

  /// `He will be able to view the content of the boards only, without any additional permissions.`
  String get guest_desc {
    return Intl.message(
      'He will be able to view the content of the boards only, without any additional permissions.',
      name: 'guest_desc',
      desc: '',
      args: [],
    );
  }

  /// `He can add, delete and edit within the app, but he will not be able to add apps or control settings.`
  String get user_desc {
    return Intl.message(
      'He can add, delete and edit within the app, but he will not be able to add apps or control settings.',
      name: 'user_desc',
      desc: '',
      args: [],
    );
  }

  /// `Select users`
  String get select_users {
    return Intl.message(
      'Select users',
      name: 'select_users',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `No date`
  String get no_date {
    return Intl.message(
      'No date',
      name: 'no_date',
      desc: '',
      args: [],
    );
  }

  /// `Last modified`
  String get last_modified {
    return Intl.message(
      'Last modified',
      name: 'last_modified',
      desc: '',
      args: [],
    );
  }

  /// `Readable`
  String get readable {
    return Intl.message(
      'Readable',
      name: 'readable',
      desc: '',
      args: [],
    );
  }

  /// `Unreadable`
  String get unreadable {
    return Intl.message(
      'Unreadable',
      name: 'unreadable',
      desc: '',
      args: [],
    );
  }

  /// `Task copied successfully`
  String get task_copied_successfully {
    return Intl.message(
      'Task copied successfully',
      name: 'task_copied_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter a message`
  String get enter_a_message {
    return Intl.message(
      'Enter a message',
      name: 'enter_a_message',
      desc: '',
      args: [],
    );
  }

  /// `No boards available \n Create a board to see it`
  String get no_boards_available {
    return Intl.message(
      'No boards available \n Create a board to see it',
      name: 'no_boards_available',
      desc: '',
      args: [],
    );
  }

  /// `Please Check your internet and try again`
  String get please_check_your_internet_and_try_again {
    return Intl.message(
      'Please Check your internet and try again',
      name: 'please_check_your_internet_and_try_again',
      desc: '',
      args: [],
    );
  }

  /// `You cannot change the status of that task.`
  String get you_cannot_change_the_status_of_that_task {
    return Intl.message(
      'You cannot change the status of that task.',
      name: 'you_cannot_change_the_status_of_that_task',
      desc: '',
      args: [],
    );
  }

  /// `Replying to`
  String get replying_to {
    return Intl.message(
      'Replying to',
      name: 'replying_to',
      desc: '',
      args: [],
    );
  }

  /// `Add board`
  String get add_board {
    return Intl.message(
      'Add board',
      name: 'add_board',
      desc: '',
      args: [],
    );
  }

  /// `Add application`
  String get add_application {
    return Intl.message(
      'Add application',
      name: 'add_application',
      desc: '',
      args: [],
    );
  }

  /// `Settings board`
  String get settings_board {
    return Intl.message(
      'Settings board',
      name: 'settings_board',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
