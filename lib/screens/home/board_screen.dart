import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/core/shimmer/board_shimmer.dart';
import 'package:files_manager/cubits/add_board_cubit/add_board_cubit.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_favorite_cubit/board_favorite_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/board_model.dart';
import 'package:files_manager/widgets/home/board_card.dart';
import 'package:files_manager/widgets/home/custom_appbar.dart';
import '../../core/functions/color_to_hex.dart';
import '../../cubits/board_cubit/board_cubit.dart';
import '../../cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
import '../../models/member_model.dart';
import '../../models/user_model.dart';
import '../../widgets/helper/no_data.dart';
import '../add_board_screen/add_board_screen.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allBoardsCubit = context.read<AllBoardsCubit>();
    final addBoardCubit = context.read<AddBoardCubit>();
    final favoriteCubit = context.read<BoardFavoriteCubit>();
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).my_boards,
        leading: BlocConsumer<AddBoardCubit, AddBoardState>(
          listener: (context, state) {
            if (state is AddBoardFailedState) {
              errorDialog(context: context, text: state.errorMessage);
            } else if (state is AddBoardExpiredState) {
              showExpiredDialog(
                context: context,
                onConfirmBtnTap: () async {
                  await CashNetwork.clearCash();
                  Phoenix.rebirth(context);
                  await Hive.box('main').clear();
                },
              );
            } else if (state is AddBoardSuccessState) {
              Navigator.pop(context);
              state.isSubBoard
                  ? null
                  : allBoardsCubit.addNewBoard(newBoard: state.createdBoard);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            BoardCubit(currentBoard: state.createdBoard)
                              ..initState(
                                context: context,
                                uuid: state.createdBoard.uuid,
                              ),
                      ),
                      BlocProvider(
                        create: (context) => ApplicationCubit()
                          ..initState(
                            context: context,
                            uuid: state.createdBoard.uuid,
                          ),
                      ),
                      BlocProvider(
                        create: (context) => LeaveFromBoardCubit(),
                      ),
                      BlocProvider(
                        create: (context) => AddBoardCubit(),
                      ),
                    ],
                    child: AddBoardScreen(
                      uuid: state.createdBoard.uuid,
                      allBoardsCubit: allBoardsCubit,
                    ),
                  ),
                ),
              );
            } else if (state is AddBoardLoadingState) {
              loadingDialog(
                  context: context,
                  mediaQuery: mediaQuery,
                  title: S.of(context).adding_board);
            }
          },
          builder: (context, state) {
            return IconButton(
              tooltip: S.of(context).add_board,
              onPressed: () async {
                await addBoardCubit.addBoard(context: context);
              },
              icon: const Icon(Icons.add),
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: S.of(context).daily_report,
            onPressed: () {
              Navigator.of(context).pushNamed('/report_screen');
            },
            icon: Icon(
              Icons.edit_document,
              color: Colors.white,
              size: mediaQuery.width / 15,
            ),
          ),
        ],
      ),
      body: BlocConsumer<LeaveFromBoardCubit, LeaveFromBoardState>(
        listener: (context, state) {
          if (state is LeaveFromBoardLoadingState) {
            loadingDialog(
                context: context,
                mediaQuery: mediaQuery,
                title: S.of(context).leaving);
          } else if (state is LeaveFromBoardSuccessState) {
            Navigator.pop(context);
            allBoardsCubit.removeBoard(index: state.index);
          } else if (state is LeaveFromBoardFailedState) {
            // Navigator.pop(context);
            errorDialog(context: context, text: state.errorMessage);
          } else if (state is LeaveFromBoardExpiredState) {
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
          return BlocConsumer<AllBoardsCubit, AllBoardsState>(
            listener: (context, state) {
              if (state is AllBoardsFailedState) {
                errorDialog(context: context, text: state.errorMessage);
              } else if (state is AllBoardsExpiredState) {
                showExpiredDialog(
                  context: context,
                  onConfirmBtnTap: () async {
                    await CashNetwork.clearCash();
                    await Hive.box('main').clear();
                    Phoenix.rebirth(context);
                  },
                );
              } else if (state is AllBoardsNoInternetState) {
                internetDialog(context: context, mediaQuery: mediaQuery);
              } else if (state is AllBoardsSuccessState) {
                final isLastPage = state.isReachMax;
                print('Is the last page => $isLastPage');
                if (isLastPage) {
                  allBoardsCubit.pagingController
                      .appendLastPage(state.newBoards);
                } else {
                  final nextPageKey = (allBoardsCubit.allBoards.length ~/
                          allBoardsCubit.pageSize) +
                      1;
                  print('The next page is =>$nextPageKey');
                  allBoardsCubit.pagingController
                      .appendPage(state.newBoards, nextPageKey);
                }
              }
            },
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await allBoardsCubit.refreshData();
                },
                child: BoardWidget(
                  allBoardsCubit: allBoardsCubit,
                  addBoardCubit: addBoardCubit,
                  favoriteCubit: favoriteCubit,
                  currentBoard: Board(
                      id: 1,
                      uuid: '1',
                      parentId: null,
                      userId: 1,
                      language: Language(
                          id: 1, name: 'english', code: 'en', direction: 'lr'),
                      roleInBoard: 'admin',
                      color: colorToHex(const Color.fromARGB(255, 27, 27, 27)),
                      tasksCommentsCount: 0,
                      shareLink: '',
                      title: 'First Group',
                      description: 'This group has many files to edit',
                      icon: '',
                      hasImage: false,
                      isFavorite: false,
                      image: '',
                      visibility: '',
                      createdAt: DateTime.now(),
                      children: [],
                      members: [
                        Member(
                            id: 1,
                            country: Country(
                                id: 1,
                                name: 'damascus',
                                iso3: '+963',
                                code: '123'),
                            language: Language(
                                id: 1,
                                name: 'english',
                                code: 'en',
                                direction: 'lr'),
                            gender: Gender(id: 1, type: 'male'),
                            firstName: 'Alaa',
                            lastName: 'Shibany',
                            mainRole: 'admin',
                            role: 'admin',
                            dateOfBirth: '2002-11-28',
                            countryCode: '+963',
                            phone: '981233473',
                            email: 'alaashibany@gmail.com',
                            image: '')
                      ],
                      invitedUsers: []),
                  currentIndex: 0,
                ).animate().fade(
                      duration: const Duration(milliseconds: 500),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
