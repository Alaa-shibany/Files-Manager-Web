import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  bool showPassword = false;
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  String? countryCode;
  // String? selectedCountry;
  String? selectedLanguage;
  // String? selectedGender;
  DateTime? selectedDateOfBirth = DateTime.now();
  List<Country> countries = [];
  List<Language> languages = [];
  List<Gender> genders = [];

  final formKey = GlobalKey<FormState>();

  void toggleShowPassword(bool show) {
    emit(ShowPassword(show: show));
  }

  // final firebaseMessaging = FirebaseMessaging.instance;
  final box = Hive.box('main');

  Future<void> register({required BuildContext context}) async {
    print('step1');
    try {
      String? fcmToken;
      if (!await checkInternet()) {
        internetToast(context: context);
        return;
      }
      emit(RegisterLoadingState());
      print('step2');
      // await FirebaseMessaging.instance.deleteToken().then(
      //   (value) async {
      //     fcmToken = await firebaseMessaging.getToken();
      //   },
      // );
      print('step3');

      FormData formData = FormData.fromMap({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': whatsappNumberController.text,
        'country_code': countryCode,
        // 'country_id': selectedCountry,
        'country_id': '1',
        'language_id': selectedLanguage,
        // 'gender_id': selectedGender,
        'gender_id': '1',
        'date_of_birth': selectedDateOfBirth?.toIso8601String(),
      });
      print('Data Before Send Register is $formData');
      // print('Data Before Send Register1 Country  $selectedCountry');
      // print('Data Before Send Register2 Gender $selectedGender');
      print('Data Before Send Register3 Language $selectedLanguage');
      print('FCM Token To Send Is :=>  $fcmToken');
      final response = await dio().post('auth/register', data: formData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        CashNetwork.insertToCash(key: 'email', value: emailController.text);
        await CashNetwork.insertToCash(
            key: 'first_name', value: response.data['user']['first_name']);
        await CashNetwork.insertToCash(
            key: 'last_name', value: response.data['user']['last_name']);
        await CashNetwork.insertToCash(
            key: 'phone', value: response.data['user']['phone']);
        await CashNetwork.insertToCash(
            key: 'country_code', value: response.data['user']['country_code']);

        await CashNetwork.insertToCash(
            key: 'role', value: response.data['user']['role'] ?? '');
        // print('register success');
        // final User userData = User.fromJson(response.data['data']);
        // box.put('user', userData);
        print('------register response');
        print(response.data);
        print('------------------------------------------------');
        emit(RegisterSuccessState());
      }
    } on DioException catch (e) {
      Navigator.pop(context);
      print(e.toString());
      errorHandler(e: e, context: context);
      print('================dio exception ====================');
      if (e.response!.statusCode! > 400) {
        print('The response code is => ${e.response!.statusCode!}');
        print('The Message response code is => ${e.response!.data['message']}');
        emit(
          RegisterFailureState(errorMessage: e.response!.data['message']),
        );
        return;
      }
      emit(RegisterFailureState(errorMessage: e.response!.data.toString()));
    } catch (e) {
      print('General error is : $e');
      print('=============catch exception =========================');
      Navigator.of(context).pop;
      emit(RegisterFailureState(errorMessage: e.toString()));
    }
  }

  // void setSelectedCountry(String? country) {
  //   selectedCountry = country;
  //   emit(RegisterCountryChanged());
  // }

  void setSelectedLanguage(String? language) {
    selectedLanguage = language;
    emit(RegisterLanguageChanged());
  }

  // void setSelectedGender(String? gender) {
  //   selectedGender = gender;
  //   emit(RegisterGenderChanged());
  // }

  void setDateOfBirth(DateTime date) {
    selectedDateOfBirth = date;
    emit(RegisterDateOfBirthChanged());
  }

  // Fetch Country Function
  // Future<void> fetchCountry(BuildContext context) async {
  //   emit(FetchDataLoading());
  //   try {
  //     String? token = CashNetwork.getCashData(key: 'token');
  //     final response = await dio().get(
  //       'countries/get-all',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data['countries']['data'];
  //       print(data);
  //       countries = List<Country>.from(
  //           data.map((item) => Country(item['id'].toString(), item['name'])));
  //       emit(FetchDataSuccess());
  //     } else {
  //       emit(FetchDataFailure(errorMessage: response.data));
  //     }
  //   } catch (e) {
  //     emit(FetchDataFailure(errorMessage: e.toString()));
  //   }
  // }

// Fetch Language Function
  Future<void> fetchLanguageFunction(BuildContext context) async {
    emit(FetchDataLoading());
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      final response = await dio().get(
        'languages/get-all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['languages']['data'];
        print(data);

        languages = List<Language>.from(
            data.map((item) => Language(item['id'].toString(), item['name'])));
        emit(FetchDataSuccess());
      } else {
        emit(FetchDataFailure(errorMessage: response.data));
      }
    } catch (e) {
      emit(FetchDataFailure(errorMessage: e.toString()));
    }
  }

// Fetch Gender Function
  // Future<void> fetchGenderFunction(BuildContext context) async {
  //   emit(FetchDataLoading());
  //   try {
  //     String? token = CashNetwork.getCashData(key: 'token');
  //     final response = await dio().get(
  //       'genders/get-all',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data['genders']['data'];
  //       print(data);

  //       genders = List<Gender>.from(
  //           data.map((item) => Gender(item['id'].toString(), item['type'])));
  //       emit(FetchDataSuccess());
  //     } else {
  //       print(response.data);
  //       emit(FetchDataFailure(errorMessage: response.data));
  //     }
  //   } catch (e) {
  //     print(e);
  //     emit(FetchDataFailure(errorMessage: e.toString()));
  //   }
  // }
}

class Country {
  final String id;
  final String name;

  Country(this.id, this.name);
}

class Language {
  final String id;
  final String name;

  Language(this.id, this.name);
}

class Gender {
  final String id;
  final String name;

  Gender(this.id, this.name);
}
