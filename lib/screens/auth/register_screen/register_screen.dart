import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/cubits/auth/register_cubit/register_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_button_widget.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/custom_text_fields/phon_form_field_widget.dart';
import '../../../core/functions/validate_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void closeLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final validator = Validate(context: context);
    final cubit = context.read<RegisterCubit>();
    InputDecoration? decoration = InputDecoration(
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
    );
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          loadingDialog(context: context, mediaQuery: mediaQuery);
        } else if (state is RegisterSuccessState) {
          showLightSnackBar(context, S.of(context).register_success_message);
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login_screen',
            (route) => false,
          );
        } else if (state is RegisterFailureState) {
          errorDialog(context: context, text: state.errorMessage);
        }
      },
      builder: (context, state) {
        bool showPassword = state is ShowPassword ? state.show : true;
        return Scaffold(
          backgroundColor: AppColors.dark,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.dark,
            toolbarHeight: 45,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          body: GestureDetector(
            onTap: () {},
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.height / 60),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: mediaQuery.height / 12),
                    Image(
                      image: const AssetImage('assets/icons/logo.png'),
                      height: mediaQuery.height / 8,
                    ),
                    SizedBox(height: mediaQuery.height / 20),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).sign_up,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: mediaQuery.width / 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mediaQuery.width / 2.2,
                              child: CustomFormTextField(
                                keyboardType: TextInputType.text,
                                controller: cubit.firstNameController,
                                colorIcon: Colors.grey,
                                hintText: '',
                                nameLabel: S.of(context).first_name,
                              ),
                            ),
                            SizedBox(
                              width: mediaQuery.width / 2.2,
                              child: CustomFormTextField(
                                keyboardType: TextInputType.text,
                                controller: cubit.lastNameController,
                                colorIcon: Colors.grey,
                                hintText: '',
                                nameLabel: S.of(context).last_name,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        CustomFormTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: cubit.emailController,
                          colorIcon: Colors.grey,
                          hintText: 'email@example.com',
                          nameLabel: S.of(context).email,
                          validator: validator.validateEmail,
                        ),
                        PhonFormFieldWidget(
                          initialCountryCode: '',
                          controller: cubit.whatsappNumberController,
                          onCountryCodeChanged: (value) {
                            cubit.countryCode = value;
                          },
                        ),
                        // SizedBox(height: mediaQuery.height / 50),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(S.of(context).select_country,
                            //     style: const TextStyle(color: Colors.white)),
                            // DropdownButtonFormField<String>(
                            //   decoration: decoration,
                            //   value: cubit.selectedCountry,
                            //   hint: Text(S.of(context).select_country),
                            //   items: cubit.countries.map((Country country) {
                            //     return DropdownMenuItem<String>(
                            //       value: country.id,
                            //       child: Text(country.name,
                            //           style:
                            //               const TextStyle(color: Colors.black)),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     cubit.setSelectedCountry(newValue);
                            //   },
                            // ),
                            // SizedBox(height: mediaQuery.height / 50),
                            Text(S.of(context).select_language,
                                style: const TextStyle(color: Colors.white)),
                            DropdownButtonFormField<String>(
                              decoration: decoration,
                              value: cubit.selectedLanguage,
                              hint: Text(S.of(context).language),
                              items: cubit.languages.map((Language language) {
                                return DropdownMenuItem<String>(
                                  value: language.id,
                                  child: Text(
                                    language.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                cubit.setSelectedLanguage(newValue);
                              },
                            ),
                            // SizedBox(height: mediaQuery.height / 50),
                            // Text(S.of(context).select_gender,
                            //     style: const TextStyle(color: Colors.white)),
                            // DropdownButtonFormField<String>(
                            //   elevation: 5,
                            //   decoration: decoration,
                            //   value: cubit.selectedGender,
                            //   hint: Text(
                            //     S.of(context).select_gender,
                            //     style: const TextStyle(color: Colors.black),
                            //   ),
                            //   items: cubit.genders.map((Gender gender) {
                            //     return DropdownMenuItem<String>(
                            //       value: gender.id,
                            //       child: Text(gender.name,
                            //           style:
                            //               const TextStyle(color: Colors.black)),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     cubit.setSelectedGender(newValue);
                            //   },
                            // ),
                          ],
                        ),
                        // SizedBox(height: mediaQuery.height / 50),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     DateTime? pickedDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime.now(),
                        //       firstDate: DateTime(1900),
                        //       lastDate: DateTime.now(),
                        //     );
                        //     if (pickedDate != null) {
                        //       cubit.setDateOfBirth(pickedDate);
                        //     }
                        //   },
                        //   child: Text(
                        //     cubit.selectedDateOfBirth != null
                        //         ? cubit.selectedDateOfBirth!
                        //             .toString()
                        //             .substring(0, 10)
                        //         : S.of(context).select_birth_date,
                        //     style: const TextStyle(color: Colors.white),
                        //   ),
                        // ),
                        //Password
                        SizedBox(height: mediaQuery.height / 50),
                        CustomFormTextField(
                          obscureText: showPassword,
                          keyboardType: TextInputType.text,
                          controller: cubit.passwordController,
                          icon: showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          colorIcon: Colors.grey,
                          hintText: '******',
                          nameLabel: S.of(context).password,
                          onPressedIcon: () {
                            BlocProvider.of<RegisterCubit>(context)
                                .toggleShowPassword(!showPassword);
                          },
                          validator: validator.validatePassword,
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        //ReEnter Password
                        CustomFormTextField(
                          obscureText: showPassword,
                          keyboardType: TextInputType.text,
                          controller: cubit.reEnterPasswordController,
                          icon: showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          colorIcon: Colors.grey,
                          hintText: '******',
                          nameLabel: S.of(context).re_password,
                          onPressedIcon: () {
                            BlocProvider.of<RegisterCubit>(context)
                                .toggleShowPassword(!showPassword);
                          },
                          validator: validator.validateRePassword,
                        ),
                        SizedBox(height: mediaQuery.height / 50),
                        CustomButtonWidget(
                          mediaQuery: mediaQuery,
                          title: S.of(context).sign_up,
                          onPressed: () {
                            // print('Country ${cubit.selectedCountry}');
                            // print('Gender ${cubit.selectedGender}');
                            print('Language ${cubit.selectedLanguage}');
                            if (cubit.formKey.currentState!.validate()) {
                              if (cubit.reEnterPasswordController.text !=
                                  cubit.passwordController.text) {
                                return showLightSnackBar(
                                    context, S.of(context).password_must_match);
                              }
                              cubit.register(context: context);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: mediaQuery.height / 20),
                  ],
                ),
              )
                  .animate()
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: const Duration(milliseconds: 300),
                  )
                  .fade(),
            ),
          ),
        );
      },
    );
  }
}
