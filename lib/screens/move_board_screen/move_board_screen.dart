import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/core/shimmer/board_shimmer.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/barent_boards_cubit/parent_boards_cubit.dart';
import 'package:files_manager/cubits/move_board_cubit/move_board_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

import '../../core/animation/dialogs/dialogs.dart';
import '../../core/animation/dialogs/expired_dialog.dart';
import '../../models/board_model.dart';
import '../../widgets/helper/no_data.dart';

class MoveBoardScreen extends StatelessWidget {
  const MoveBoardScreen(
      {super.key, required this.movedBoard, required this.allBoardsCubit});
  final Board movedBoard;
  final AllBoardsCubit allBoardsCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final parentBoardCubit = context.read<ParentBoardsCubit>();
    final moveBoardCubit = context.read<MoveBoardCubit>();
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
            'نقل اللوحة إلى',
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.width / 15),
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
      body: BlocConsumer<ParentBoardsCubit, ParentBoardsState>(
        listener: (context, state) {
          if (state is ParentBoardsFailedState) {
            errorDialog(context: context, text: state.errorMessage);
          } else if (state is ParentBoardsExpiredState) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                Phoenix.rebirth(context);
              },
            );
          } else if (state is ParentBoardsNoInternetState) {
            internetDialog(context: context, mediaQuery: mediaQuery);
          } else if (state is ParentBoardsSuccessState) {
            final isLastPage = state.isReachMax;
            print('Is the last page => $isLastPage');
            if (isLastPage) {
              parentBoardCubit.pagingController.appendLastPage(state.newBoards);
            } else {
              final nextPageKey = (parentBoardCubit.allParentBoards.length ~/
                      parentBoardCubit.pageSize) +
                  1;
              print('The next page is =>$nextPageKey');
              parentBoardCubit.pagingController
                  .appendPage(state.newBoards, nextPageKey);
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: mediaQuery.height / 1.5,
                child: PagedListView<int, Board>(
                  padding: EdgeInsets.zero,
                  pagingController: parentBoardCubit.pagingController,
                  shrinkWrap: true,
                  builderDelegate: PagedChildBuilderDelegate<Board>(
                      itemBuilder: (context, item, index) => item.id ==
                              movedBoard.id
                          ? const SizedBox()
                          : Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: mediaQuery.height / 20,
                                              child: item.hasImage
                                                  ? item.image.isEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      360),
                                                          child: Image.file(
                                                            item.imageFile!,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: item.image,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer
                                                                  .fromColors(
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                          fit: BoxFit.contain,
                                                        )
                                                  : CircleAvatar(
                                                      child: Text(item.icon),
                                                    ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              item.title,
                                              style: const TextStyle(
                                                color: AppColors.dark,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Radio(
                                          value: item.id,
                                          groupValue:
                                              parentBoardCubit.selectedBoard,
                                          onChanged: (value) async {
                                            parentBoardCubit
                                                .selectBoard(value!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fade(
                              duration: const Duration(milliseconds: 500)),
                      noItemsFoundIndicatorBuilder: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NoData(
                                iconData: Icons.task_alt_rounded,
                                text: S.of(context).no_product_available,
                              ),
                            ],
                          ),
                      firstPageProgressIndicatorBuilder: (context) =>
                          const BoardShimmer(),
                      newPageProgressIndicatorBuilder: (context) =>
                          const BoardShimmer()),
                ),
              ),
              BlocConsumer<MoveBoardCubit, MoveBoardState>(
                listener: (context, state) {
                  if (state is MoveBoardLoadingState) {
                    loadingDialog(
                        context: context,
                        mediaQuery: mediaQuery,
                        title: 'جاري نقل اللوحة');
                  } else if (state is MoveBoardSuccessState) {
                    Navigator.pop(context);
                    movedBoard.parentId = parentBoardCubit.selectedBoard;
                    allBoardsCubit.pagingController.itemList!
                        .where(
                          (element) =>
                              element.id == parentBoardCubit.selectedBoard,
                        )
                        .first
                        .children
                        .add(movedBoard);
                    Navigator.pop(context);
                    allBoardsCubit.refresh();
                  } else if (state is MoveBoardFailedState) {
                    errorDialog(context: context, text: state.errorMessage);
                  } else if (state is MoveBoardExpiredState) {
                    showExpiredDialog(
                      context: context,
                      onConfirmBtnTap: () async {
                        await CashNetwork.clearCash();
                        await Hive.box('main').clear();
                        await Phoenix.rebirth(context);
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        await moveBoardCubit.moveBoard(
                            context: context,
                            boardId: parentBoardCubit.selectedBoard.toString(),
                            movedBoardUuid: movedBoard.uuid);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: mediaQuery.width / 2,
                        child: const Text(
                          'نقل اللوحة',
                          style: TextStyle(
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
