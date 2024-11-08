import 'package:cached_network_image/cached_network_image.dart';
import 'package:files_manager/core/functions/statics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/move_application_cubit/move_application_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/theme/color.dart';

class MoveApplicationScreen extends StatelessWidget {
  const MoveApplicationScreen(
      {super.key,
      required this.boardCubit,
      required this.allBoardsCubit,
      required this.isCopy,
      required this.applicationCubit,
      required this.application});
  final BoardCubit boardCubit;
  final AllBoardsCubit allBoardsCubit;
  final Application application;
  final bool isCopy;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    // final parentBoardCubit = context.read<ParentBoardsCubit>();
    final moveApplicationCubit = context.read<MoveApplicationCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGray,
        flexibleSpace: SizedBox(
          height: mediaQuery.height / 3,
        ),
        toolbarHeight: mediaQuery.height / 12,
        title: SizedBox(
          width: mediaQuery.width / 1.3,
          child: Text(
            isCopy ? 'Copy application to' : 'Share application',
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Statics.isPlatformDesktop
                    ? mediaQuery.width / 45
                    : mediaQuery.width / 15),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<MoveApplicationCubit, MoveApplicationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              isCopy
                  ? CheckboxListTile(
                      value: moveApplicationCubit.moveWithContent,
                      onChanged: (value) async {
                        await moveApplicationCubit.changeContentState();
                      },
                      title: const Text(
                        'نسخ التطبيق مع المحتوى',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: mediaQuery.height / 1.5,
                width: mediaQuery.width,
                child: Statics.isPlatformDesktop
                    ? Wrap(
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          allBoardsCubit.allBoards.length,
                          (index) {
                            return allBoardsCubit.allBoards[index].id ==
                                    boardCubit.currentBoard.id
                                ? const SizedBox()
                                : SizedBox(
                                    width: mediaQuery.width / 3,
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          mediaQuery.height /
                                                              20,
                                                      child: allBoardsCubit
                                                              .allBoards[index]
                                                              .hasImage
                                                          ? allBoardsCubit
                                                                  .allBoards[
                                                                      index]
                                                                  .image
                                                                  .isEmpty
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              360),
                                                                  child: Image
                                                                      .file(
                                                                    allBoardsCubit
                                                                        .allBoards[
                                                                            index]
                                                                        .imageFile!,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                )
                                                              : CachedNetworkImage(
                                                                  imageUrl: allBoardsCubit
                                                                      .allBoards[
                                                                          index]
                                                                      .image,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                    baseColor:
                                                                        Colors.grey[
                                                                            300]!,
                                                                    highlightColor:
                                                                        Colors.grey[
                                                                            100]!,
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                          : CircleAvatar(
                                                              child: Text(
                                                                  allBoardsCubit
                                                                      .allBoards[
                                                                          index]
                                                                      .icon),
                                                            ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          allBoardsCubit
                                                              .allBoards[index]
                                                              .title,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                AppColors.dark,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Radio(
                                                  value: allBoardsCubit
                                                      .allBoards[index].id,
                                                  groupValue:
                                                      moveApplicationCubit
                                                          .selectedBoard,
                                                  onChanged: (value) async {
                                                    moveApplicationCubit
                                                        .selectBoard(value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animate().fade(
                                        duration:
                                            const Duration(milliseconds: 500)),
                                  );
                          },
                        ),
                      )
                    : ListView(
                        children: List.generate(
                          allBoardsCubit.allBoards.length,
                          (index) {
                            return allBoardsCubit.allBoards[index].id ==
                                    boardCubit.currentBoard.id
                                ? const SizedBox()
                                : Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        mediaQuery.height / 20,
                                                    child: allBoardsCubit
                                                            .allBoards[index]
                                                            .hasImage
                                                        ? allBoardsCubit
                                                                .allBoards[
                                                                    index]
                                                                .image
                                                                .isEmpty
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            360),
                                                                child:
                                                                    Image.file(
                                                                  allBoardsCubit
                                                                      .allBoards[
                                                                          index]
                                                                      .imageFile!,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              )
                                                            : CachedNetworkImage(
                                                                imageUrl:
                                                                    allBoardsCubit
                                                                        .allBoards[
                                                                            index]
                                                                        .image,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Shimmer
                                                                        .fromColors(
                                                                  baseColor:
                                                                      Colors.grey[
                                                                          300]!,
                                                                  highlightColor:
                                                                      Colors.grey[
                                                                          100]!,
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                        : CircleAvatar(
                                                            child: Text(
                                                                allBoardsCubit
                                                                    .allBoards[
                                                                        index]
                                                                    .icon),
                                                          ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        allBoardsCubit
                                                            .allBoards[index]
                                                            .title,
                                                        style: const TextStyle(
                                                          color: AppColors.dark,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Radio(
                                                value: allBoardsCubit
                                                    .allBoards[index].id,
                                                groupValue: moveApplicationCubit
                                                    .selectedBoard,
                                                onChanged: (value) async {
                                                  moveApplicationCubit
                                                      .selectBoard(value!);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animate().fade(
                                    duration:
                                        const Duration(milliseconds: 500));
                          },
                        ),
                      ),
              ),
              BlocConsumer<MoveApplicationCubit, MoveApplicationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        isCopy
                            ? await moveApplicationCubit.copyApplication(
                                context: context,
                                applicationId:
                                    application.getApplicationId().toString(),
                              )
                            : await moveApplicationCubit.moveApplication(
                                context: context,
                                applicationId:
                                    application.getApplicationId().toString(),
                              );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: mediaQuery.width / 2,
                        child: Text(
                          isCopy ? 'نسخ التطبيق' : 'نقل التطبيق',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
