import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/core/shimmer/edit_profile_shimmer.dart';
import 'package:files_manager/cubits/profile_cubit/profile_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_button_widget.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/custom_text_fields/phon_form_field_widget.dart';
import 'package:files_manager/widgets/helper/no_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(S.of(context).edit_profile),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SetProfileDetailsLoading) {
            loadingDialog(context: context, mediaQuery: mediaQuery);
          }
          if (state is SetProfileDetailsSuccess) {
            Navigator.of(context).pop();
          }
          if (state is SetProfileDetailsExpiredToken) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                Phoenix.rebirth(context);
              },
            );
          }
          if (state is SetProfileDetailsNoInternet) {
            internetDialog(context: context, mediaQuery: mediaQuery);
          }
        },
        builder: (context, state) {
          final imageProvider = profileCubit.selectedImagePath != null &&
                  profileCubit.selectedImagePath!.path.isNotEmpty
              ? FileImage(File(profileCubit.selectedImagePath!.path))
              : CachedNetworkImageProvider(profileCubit.imagePicked)
                  as ImageProvider;
          if (state is FetchCountryLoading) {
            return const EditProfileShimmer();
          }
          if (state is FetchCountrySuccess ||
              state is ProfileUpdated ||
              state is ProfileImageUpdated ||
              state is SetProfileDetailsLoading ||
              state is SetProfileDetailsSuccess) {
            return Column(
              children: [
                SizedBox(
                  height: mediaQuery.height / 4,
                  child: Stack(
                    children: [
                      Container(
                        height: mediaQuery.height / 4.5,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () => profileCubit.showImageDialog(
                                  context, imageProvider),
                              child: Container(
                                width: mediaQuery.width / 2.3,
                                height: mediaQuery.width / 2.3,
                                margin: EdgeInsets.only(
                                    bottom: mediaQuery.width / 8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD6D6D6),
                                ),
                                child: ClipOval(
                                  child: profileCubit.selectedImagePath !=
                                              null &&
                                          profileCubit.selectedImagePath!.path
                                              .isNotEmpty
                                      ? Image.file(
                                          File(profileCubit
                                              .selectedImagePath!.path),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: profileCubit.imagePicked,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              right: 15,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  tooltip: S.of(context).select_profile_picture,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  ),
                                  onPressed: () => profileCubit.pickImage(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.width / 25,
                          vertical: mediaQuery.height / 80),
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: mediaQuery.width / 2.2,
                                  child: CustomFormTextField(
                                    keyboardType: TextInputType.text,
                                    controller:
                                        profileCubit.firstNameController,
                                    colorIcon: Colors.grey,
                                    hintText: '',
                                    nameLabel: S.of(context).first_name,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuery.width / 2.2,
                                  child: CustomFormTextField(
                                    keyboardType: TextInputType.text,
                                    controller: profileCubit.lastNameController,
                                    colorIcon: Colors.grey,
                                    hintText: '',
                                    nameLabel: S.of(context).last_name,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height / 45),
                            CustomFormTextField(
                              icon: Icons.email_outlined,
                              nameLabel: S.of(context).email,
                              controller: profileCubit.emailController,
                              enabled: false,
                            ),
                            // SizedBox(height: mediaQuery.height / 45),
                            PhonFormFieldWidget(
                              onCountryCodeChanged: (p0) {},
                              controller: profileCubit.phoneNumber,
                              initialCountryCode: profileCubit.countryCode,
                            ),
                            // SizedBox(height: mediaQuery.height / 110),
                            // DropDown For City
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text('${S.of(context).city}:',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                DropdownButtonFormField<Country>(
                                  value: profileCubit.selectedCountry,
                                  items: profileCubit.countries.map((country) {
                                    return DropdownMenuItem<Country>(
                                      value: country,
                                      child: Text(
                                        country.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      profileCubit.updateCity(
                                          value.id, value.name);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    // labelText: S.of(context).city,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height / 45),
                            //DropDown For Language
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text('${S.of(context).language}:',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                DropdownButtonFormField<Language>(
                                  value: profileCubit.selectedLanguage,
                                  items: profileCubit.languages.map((language) {
                                    return DropdownMenuItem<Language>(
                                      value: language,
                                      child: Text(
                                        language.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      profileCubit.updateLanguage(
                                          value.id, value.name);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    // labelText: S.of(context).language,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height / 45),
                            // DropDown For Gender
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text('${S.of(context).gender}:',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                DropdownButtonFormField<Gender>(
                                  value: profileCubit.selectedGender,
                                  items: profileCubit.genders.map((gender) {
                                    return DropdownMenuItem<Gender>(
                                      value: gender,
                                      child: Text(
                                        gender.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      profileCubit.updateGender(
                                          value.id, value.name);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    // labelText: S.of(context).gender,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height / 45),
                            // Date picker for birth date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text('${S.of(context).birth_date}:',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                InkWell(
                                  onTap: () async {
                                    profileCubit.pickDate(context);
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // labelText: S.of(context).birth_date,
                                    ),
                                    child: Text(
                                      profileCubit.dateOfBirth,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height / 45),
                            CustomButtonWidget(
                              color: AppColors.primaryColor,
                              mediaQuery: mediaQuery,
                              title: S.of(context).save,
                              onPressed: () {
                                final firstName =
                                    profileCubit.firstNameController.text;
                                final lastName =
                                    profileCubit.lastNameController.text;
                                final dateOfBirth = profileCubit.dateOfBirth;
                                final countryCode = profileCubit.countryCode;
                                final phone = profileCubit.phoneNumber.text;
                                final email = profileCubit.emailController.text;
                                final image = (profileCubit.selectedImagePath !=
                                            null &&
                                        profileCubit.selectedImagePath!.path !=
                                            profileCubit.imagePicked)
                                    ? File(profileCubit.selectedImagePath!.path)
                                    : null;

                                print(
                                    'Country ID: ${profileCubit.selectCountryId}');
                                print(
                                    'Language ID: ${profileCubit.selectLanguageId}');
                                print(
                                    'Gender ID: ${profileCubit.selectGenderId}');
                                print('First Name: $firstName');
                                print('Last Name: $lastName');
                                print('Date of Birth: $dateOfBirth');
                                print('Country Code: $countryCode');
                                print('Phone: $phone');
                                print('Email: $email');
                                print('Image: ${image?.path}');
                                profileCubit.setProfileDetailsFun(
                                  context: context,
                                  countryId: profileCubit.selectCountryId!,
                                  languageId: profileCubit.selectLanguageId!,
                                  genderId: profileCubit.selectGenderId!,
                                  firstName: firstName,
                                  lastName: lastName,
                                  dateOfBirth: dateOfBirth,
                                  phone: phone,
                                  countryCode: countryCode,
                                  email: email,
                                  image: image,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is FetchCountryFailure) {
            return NoData(
                iconData: Icons.error, text: S.of(context).server_error);
          }
          return Container();
        },
      ),
    );
  }
}
