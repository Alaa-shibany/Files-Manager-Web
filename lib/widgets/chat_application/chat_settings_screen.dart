import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/cubits/chat_cubit/chat_settings_cubit/chat_settings_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';

class ChatSettingsScreen extends StatelessWidget {
  const ChatSettingsScreen({super.key, required this.chatCubit});
  final ChatCubit chatCubit;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final chatSettingsCubit = context.read<ChatSettingsCubit>();
    final localCubit = context.read<LocaleCubit>();

    return BlocBuilder<ChatSettingsCubit, ChatSettingsState>(
      builder: (context, state) {
        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Localizations.override(
              context: context,
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
                        controller: chatCubit.taskTitleController,
                        onChanged: (p0) async {
                          // await chatCubit.editTaskName();
                        },
                      ),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
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
                  body: BlocConsumer<ChatSettingsCubit, ChatSettingsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return TabBarView(
                        children: [
                          // Start Settings Tab
                          Column(
                            children: [
                              SizedBox(
                                width: mediaQuery.width / 1.2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    chatSettingsCubit
                                        .showLanguageDialog(context);
                                  },
                                  child: Text(
                                    S.of(context).select_language,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // End Settings Tab
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 30,
                              vertical: mediaQuery.height / 50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: mediaQuery.width / 90),
                                      child: Text(S.of(context).color),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.height / 50,
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: List.generate(
                                        allColors.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (chatCubit.chatModel
                                                      .applicationColor ==
                                                  index) {
                                                return;
                                              }
                                              await chatCubit
                                                  .selectApplicationColor(
                                                      index);
                                              await chatSettingsCubit.refresh();
                                            },
                                            child: Container(
                                              height: mediaQuery.height / 25,
                                              width: mediaQuery.width / 10,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      mediaQuery.width / 70),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: chatCubit.chatModel
                                                            .applicationColor !=
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
                                                              0, 1),
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
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 30,
                              vertical: mediaQuery.height / 50,
                            ),
                            child: const Text(
                                'استخدم هذا التطبيق كلوح كانبان أو قائمة لإضافة المهام, تنظيمها, وإسنادها لفرق عمل'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
