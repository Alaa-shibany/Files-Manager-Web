import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/cubits/update_application_cubit/update_application_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';

class ApplicationSettingsScreen extends StatelessWidget {
  const ApplicationSettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final updateApplicationCubit = context.read<UpdateApplicationCubit>();
    final localCubit = context.read<LocaleCubit>();

    return BlocConsumer<UpdateApplicationCubit, UpdateApplicationState>(
      listener: (context, state) {
        if (state is UpdateApplicationSuccessState) {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
        } else if (state is UpdateApplicationLoadingState) {
          loadingDialog(
              context: context,
              mediaQuery: mediaQuery,
              title: state.loadingMessage);
        } else if (state is UpdateApplicationFailedState) {
          errorDialog(context: context, text: state.errorMessage);
        } else if (state is UpdateApplicationExpiredState) {
          showExpiredDialog(
            context: context,
            onConfirmBtnTap: () async {
              await CashNetwork.clearCash();
              Hive.box('main');
              await Phoenix.rebirth(context);
            },
          );
        }
      },
      builder: (context, state) {
        return Localizations.override(
          context: context,
          locale: Locale(updateApplicationCubit.application.getLanguage()),
          child: WillPopScope(
            onWillPop: () async {
              await updateApplicationCubit.updateApplication(context: context);
              return false;
            },
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.darkGray,
                  flexibleSpace: SizedBox(
                    height: mediaQuery.height / 3,
                  ),
                  toolbarHeight: mediaQuery.height / 12,
                  title: SizedBox(
                    child: CustomTextFields(
                      textAlign: TextAlign.end,
                      styleInput: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQuery.width / 15),
                      controller:
                          updateApplicationCubit.applicationTitleController,
                      onChanged: (p0) async {
                        await updateApplicationCubit.changeApplicationTitle();
                      },
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () async {
                        await updateApplicationCubit.updateApplication(
                            context: context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      )),
                  bottom: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: const BoxDecoration(
                      color: AppColors.dark,
                    ),
                    tabs: [
                      Tab(
                        text: S.of(context).settings,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        text: S.of(context).shape,
                        icon: const Icon(
                          Icons.light_mode,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        text: S.of(context).info,
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                body: BlocConsumer<UpdateApplicationCubit,
                    UpdateApplicationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 30,
                              vertical: mediaQuery.height / 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.of(context).select_language,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.height / 90,
                              ),
                              BlocConsumer<UpdateApplicationCubit,
                                  UpdateApplicationState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return Container(
                                    width: mediaQuery.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: mediaQuery.width / 40,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white10,
                                        width: 1,
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: updateApplicationCubit.application
                                          .getLanguage(),
                                      dropdownColor: AppColors.dark,
                                      underline: const SizedBox(),
                                      items: [
                                        DropdownMenuItem(
                                            value: 'default',
                                            child: Text(
                                              S.of(context).default_language,
                                            )),
                                        DropdownMenuItem(
                                            value: 'ar',
                                            child: Text(
                                              S.of(context).arabic,
                                            )),
                                        DropdownMenuItem(
                                          value: 'en',
                                          child: Text(
                                            S.of(context).english,
                                          ),
                                        ),
                                      ],
                                      onChanged: (String? newValue) async {
                                        if (newValue == 'default') {
                                          await updateApplicationCubit
                                              .updateLanguage(
                                                  newLanguage: localCubit
                                                      .locale.languageCode);
                                        } else {
                                          await updateApplicationCubit
                                              .updateLanguage(
                                                  newLanguage: newValue);
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 30,
                              vertical: mediaQuery.height / 50,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).color,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.height / 120,
                                ),
                                BlocConsumer<UpdateApplicationCubit,
                                    UpdateApplicationState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return Wrap(
                                      alignment: WrapAlignment.start,
                                      children: List.generate(
                                        allColors.length - 1,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (index ==
                                                  allColors.length - 1) {
                                                // showColorPicker(
                                                //     context,
                                                //     updateApplicationCubit,
                                                //     index);
                                              } else {
                                                await updateApplicationCubit
                                                    .updateApplicationColor(
                                                        colorIndex: index);
                                              }
                                            },
                                            child: Container(
                                              height: mediaQuery.height / 25,
                                              width: mediaQuery.width / 10,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      mediaQuery.width / 70),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: updateApplicationCubit
                                                            .application
                                                            .getApplicationSelectedColor() !=
                                                        index
                                                    ? null
                                                    : [
                                                        BoxShadow(
                                                          color: Colors
                                                              .blueAccent
                                                              .withOpacity(0.7),
                                                          spreadRadius: 5,
                                                          blurRadius: 5,
                                                          offset: const Offset(
                                                              0,
                                                              1), // changes position of shadow
                                                        ),
                                                      ],
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                                color: allColors[index]['show'],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: mediaQuery.height / 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showColorPicker(
                                          context,
                                          updateApplicationCubit,
                                        );
                                      },
                                      child: SizedBox(
                                        width: mediaQuery.width / 3,
                                        child: Text(
                                          S.of(context).pick_a_color,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        showColorPicker(
                                          context,
                                          updateApplicationCubit,
                                        );
                                      },
                                      child: Container(
                                        height: mediaQuery.height / 25,
                                        width: mediaQuery.width / 10,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: mediaQuery.width / 70),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          color: allColors.last['show'],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width / 30,
                            vertical: mediaQuery.height / 50,
                          ),
                          child: Text(updateApplicationCubit.application
                              .getApplicationAbout()),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showColorPicker(
    BuildContext context,
    UpdateApplicationCubit applicationCubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).pick_a_color),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: allColors.last['real']!,
              onColorChanged: (Color color) {
                allColors.last['show'] = color;
                allColors.last['real'] = color;
                applicationCubit.updateApplicationColor(
                    colorIndex: allColors.length - 1);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).select),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
