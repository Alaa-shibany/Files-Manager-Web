import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/cubits/board_settings_cubit/board_settings_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:image_cropper/image_cropper.dart';

class BoardSettingsSection extends StatelessWidget {
  const BoardSettingsSection(
      {super.key, required this.mediaQuery, required this.boardSettingsCubit});
  final Size mediaQuery;
  final BoardSettingsCubit boardSettingsCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.width / 30,
        vertical: mediaQuery.height / 90,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mediaQuery.height / 50,
            ),
            Text(
              S.of(context).board_image,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: mediaQuery.height / 90,
            ),
            BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return GestureDetector(
                  child: Container(
                    height: mediaQuery.height / 5,
                    width: mediaQuery.width,
                    alignment: Alignment.center,
                    child: boardSettingsCubit.currentBoard.hasImage
                        ? boardSettingsCubit.currentBoard.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(360),
                                child: Image.file(
                                  boardSettingsCubit.currentBoard.imageFile!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: boardSettingsCubit.currentBoard.image,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 51, 53, 54),
                                  highlightColor: Colors.grey[900]!,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 51, 53, 54),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.contain,
                              )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image),
                              Text(
                                S.of(context).board_image,
                              )
                            ],
                          ),
                  ),
                );
              },
            ),
            SizedBox(
              height: mediaQuery.height / 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await boardSettingsCubit.deleteBoardImage();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.transparent),
                  child: Container(
                    alignment: Alignment.center,
                    width: mediaQuery.width / 3,
                    child: Text(
                      S.of(context).delete_image,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final XFile? pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final croppedFile = await ImageCropper().cropImage(
                        sourcePath: pickedFile.path,
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarTitle: S.of(context).crop_image,
                            toolbarColor: AppColors.dark,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: true,
                            cropStyle: CropStyle.circle,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                            ],
                          ),
                          IOSUiSettings(
                            cropStyle: CropStyle.circle,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                            ],
                            title: S.of(context).crop_image,
                          ),
                        ],
                      );
                      if (croppedFile != null) {
                        await boardSettingsCubit.pickBoardImage(
                            file: croppedFile);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: Container(
                    alignment: Alignment.center,
                    width: mediaQuery.width / 3,
                    child: Text(
                      S.of(context).add_image,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuery.height / 40,
            ),
            Text(
              S.of(context).board_icon,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    await boardSettingsCubit.showEmojiKeyboard();
                  },
                  child: Container(
                    height: mediaQuery.height / 10,
                    width: mediaQuery.width,
                    alignment: Alignment.center,
                    child: Text(
                      boardSettingsCubit.currentBoard.icon,
                      style: TextStyle(fontSize: mediaQuery.width / 10),
                    ),
                  ),
                );
              },
            ),
            BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return boardSettingsCubit.emojiKeyboard
                    ? EmojiPicker(
                        onEmojiSelected: (category, emoji) async {
                          await boardSettingsCubit.showEmojiKeyboard();
                          await boardSettingsCubit.selectEmoji(emoji.emoji);

                          print('selectEmoji');
                        },
                        config: const Config(),
                      )
                    : const SizedBox();
              },
            ),
            Text(
              S.of(context).select_language,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: mediaQuery.height / 60,
            ),
            BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
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
                    value: boardSettingsCubit.currentBoard.language.code,
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
                      await boardSettingsCubit.selectLanguage(
                          newValue!, context.read<LocaleCubit>());
                      print(
                          ' ===========I Change Language here =============$newValue=======');
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: mediaQuery.height / 40,
            ),
            Text(
              S.of(context).description,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: mediaQuery.height / 120,
            ),
            CustomFormTextField(
              controller: boardSettingsCubit.descriptionController,
              nameLabel: '',
              hintText: '',
              fillColor: Colors.transparent,
              borderColor: Colors.white10,
              styleInput: const TextStyle(color: Colors.white),
              maxLines: 5,
              borderRadius: 0.0,
              onChanged: (p0) async {
                await boardSettingsCubit.changeDescription();
              },
              validator: (p0) {
                return null;
              },
            ),
            SizedBox(
              height: mediaQuery.height / 90,
            ),
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
            BlocConsumer<BoardSettingsCubit, BoardSettingsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    allColors.length - 1,
                    (index) {
                      return GestureDetector(
                        onTap: () async {
                          await boardSettingsCubit.selectColor(index);
                        },
                        child: Container(
                          height: mediaQuery.height / 25,
                          width: mediaQuery.width / 10,
                          margin: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 70),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: boardSettingsCubit.currentBoard
                                        .getApplicationSelectedColor() !=
                                    index
                                ? null
                                : [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.7),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                            border: Border.all(color: Colors.white, width: 2),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showColorPicker(
                        context,
                        boardSettingsCubit,
                      );
                    },
                    child: SizedBox(
                      width: mediaQuery.width / 3,
                      child: const Text(
                        'Color picker',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                GestureDetector(
                  onTap: () async {
                    showColorPicker(
                      context,
                      boardSettingsCubit,
                    );
                  },
                  child: Container(
                    height: mediaQuery.height / 25,
                    width: mediaQuery.width / 10,
                    margin:
                        EdgeInsets.symmetric(horizontal: mediaQuery.width / 70),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      color: allColors.last['show'],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: mediaQuery.height / 10,
            )
          ],
        ),
      ),
    );
  }

  void showColorPicker(
    BuildContext context,
    BoardSettingsCubit boardCubit,
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
                boardCubit.selectColor(allColors.length - 1);
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
