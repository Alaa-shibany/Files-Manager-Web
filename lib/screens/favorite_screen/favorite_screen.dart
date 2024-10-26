// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:files_manager/core/animation/dialogs/dialogs.dart';
// import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
// import 'package:files_manager/core/shared/local_network.dart';
// import 'package:files_manager/core/shimmer/board_shimmer.dart';
// import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
// import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
// import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
// import 'package:files_manager/cubits/board_favorite_cubit/board_favorite_cubit.dart';
// import 'package:files_manager/cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
// import 'package:files_manager/generated/l10n.dart';
// import 'package:files_manager/models/board_model.dart';
// import 'package:files_manager/screens/add_board_screen/add_board_screen.dart';
// import 'package:files_manager/widgets/helper/no_data.dart';
// import 'package:files_manager/widgets/home/board_card.dart';
// import 'package:files_manager/widgets/home/custom_appbar.dart';

// import '../../cubits/add_board_cubit/add_board_cubit.dart';

// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     final favoriteCubit = context.read<BoardFavoriteCubit>();
//     final allBoardsCubit = context.read<AllBoardsCubit>();
//     final addBoardCubit = context.read<AddBoardCubit>();

//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: AppColors.primaryColor,
//       //   toolbarHeight: mediaQuery.height / 80,
//       // ),
//       appBar: CustomAppBar(title: S.of(context).favorite),

//       body: BlocConsumer<AddBoardCubit, AddBoardState>(
//           listener: (context, state) {
//         if (state is AddBoardSuccessState) {
//           Navigator.pop(context);
//           state.isSubBoard
//               ? null
//               : allBoardsCubit.addNewBoard(newBoard: state.createdBoard);
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => MultiBlocProvider(
//                   providers: [
//                     BlocProvider(
//                       create: (context) =>
//                           BoardCubit(currentBoard: state.createdBoard)
//                             ..initState(
//                               context: context,
//                               uuid: state.createdBoard.uuid,
//                             ),
//                     ),
//                     BlocProvider(
//                       create: (context) => ApplicationCubit()
//                         ..initState(
//                           context: context,
//                           uuid: state.createdBoard.uuid,
//                         ),
//                     ),
//                     BlocProvider(
//                       create: (context) => LeaveFromBoardCubit(),
//                     ),
//                     BlocProvider(
//                       create: (context) => AddBoardCubit(),
//                     ),
//                   ],
//                   child: AddBoardScreen(
//                     uuid: state.createdBoard.uuid,
//                     allBoardsCubit: allBoardsCubit,
//                   )),
//             ),
//           );
//         } else if (state is AddBoardLoadingState) {
//           loadingDialog(
//               context: context,
//               mediaQuery: mediaQuery,
//               title: S.of(context).adding_board);
//         }
//       }, builder: (context, state) {
//         return BlocConsumer<LeaveFromBoardCubit, LeaveFromBoardState>(
//             listener: (context, state) {
//           if (state is LeaveFromBoardLoadingState) {
//             loadingDialog(
//                 context: context,
//                 mediaQuery: mediaQuery,
//                 title: S.of(context).leaving);
//           } else if (state is LeaveFromBoardSuccessState) {
//             Navigator.pop(context);
//             allBoardsCubit.removeBoard(index: state.index);
//           } else if (state is LeaveFromBoardFailedState) {
//             // Navigator.pop(context);
//             errorDialog(context: context, text: state.errorMessage);
//           } else if (state is LeaveFromBoardExpiredState) {
//             showExpiredDialog(
//               context: context,
//               onConfirmBtnTap: () async {
//                 await CashNetwork.clearCash();
//                 await Hive.box('main').clear();
//                 await Phoenix.rebirth(context);
//               },
//             );
//           }
//         }, builder: (context, state) {
//           return BlocConsumer<BoardFavoriteCubit, BoardFavoriteState>(
//             listener: (context, state) {
//               if (state is ChangeOrderFavoriteLoading) {
//                 loadingDialog(
//                     context: context,
//                     mediaQuery: mediaQuery,
//                     title: S.of(context).saving);
//               } else if (state is ChangeOrderFavoriteFailed) {
//                 errorDialog(context: context, text: state.errorMessage);
//               } else if (state is ChangeOrderFavoriteSuccess) {
//                 Navigator.pop(context);
//               }
//               if (state is GetBoardFavoriteFailure) {
//                 errorDialog(context: context, text: state.errorMessage);
//               } else if (state is AddBoardExpiredState) {
//                 showExpiredDialog(
//                   context: context,
//                   onConfirmBtnTap: () async {
//                     await CashNetwork.clearCash();
//                     await Hive.box('main').clear();
//                     Phoenix.rebirth(context);
//                   },
//                 );
//               }
//               if (state is GetBoardFavoriteFailure) {
//                 errorDialog(context: context, text: state.errorMessage);
//               } else if (state is GetBoardFavoriteExpiredToken) {
//                 showExpiredDialog(
//                   context: context,
//                   onConfirmBtnTap: () async {
//                     await CashNetwork.clearCash();
//                     await Hive.box('main').clear();
//                     Phoenix.rebirth(context);
//                   },
//                 );
//               } else if (state is GetBoardFavoriteNoInternet) {
//                 internetDialog(context: context, mediaQuery: mediaQuery);
//               } else if (state is GetBoardFavoriteSuccess) {
//                 final isLastPage = state.isReachMax;

//                 print('Is the last page => $isLastPage');
//                 if (isLastPage) {
//                   favoriteCubit.pagingController
//                       .appendLastPage(state.newBoards);
//                 } else {
//                   final nextPageKey = (favoriteCubit.favBoards.length ~/
//                           favoriteCubit.pageSize) +
//                       1;
//                   print('The next page is =>$nextPageKey');
//                   favoriteCubit.pagingController
//                       .appendPage(state.newBoards, nextPageKey);
//                 }
//               }
//             },
//             builder: (context, state) {
//               return PagedListView<int, Board>(
//                 padding: EdgeInsets.zero,
//                 pagingController: favoriteCubit.pagingController,
//                 shrinkWrap: true,
//                 builderDelegate: PagedChildBuilderDelegate<Board>(
//                   itemBuilder: (context1, item, index) => LongPressDraggable(
//                     data: index,
//                     onDragStarted: () async {
//                       await favoriteCubit.startDragMode(index);
//                     },
//                     onDraggableCanceled: (_, __) async {
//                       print('we are leaving');
//                       await favoriteCubit.updateItemOrder(index);
//                     },
//                     feedback: MultiBlocProvider(
//                       providers: [
//                         BlocProvider(
//                           create: (context) =>
//                               BoardFavoriteCubit()..initState(context: context),
//                         ),
//                         BlocProvider(
//                           create: (context) => LeaveFromBoardCubit(),
//                         ),
//                         BlocProvider(
//                           create: (context) => AddBoardCubit(),
//                         ),
//                       ],
//                       child: BoardWidget(
//                         allBoardsCubit: allBoardsCubit,
//                         favoriteCubit: favoriteCubit,
//                         currentBoard: item,
//                         currentIndex: index,
//                       ).animate().fade(
//                             duration: const Duration(milliseconds: 500),
//                           ),
//                     ),
//                     child: DragTarget<int>(
//                       onAccept: (draggedIndex) async {
//                         await favoriteCubit.updateOnHoverItemOrder(
//                             context: context,
//                             data: draggedIndex,
//                             index: index,
//                             movedBoard: item);
//                       },
//                       // onMove: (details) async {
//                       //   // print('the index we hove on ${details.data}');
//                       //   await favoriteCubit.updateOnHoverItemOrder(
//                       //       data: details.data, index: index, movedBoard: item);
//                       // },

//                       builder: (context, candidateData, rejectedData) {
//                         return favoriteCubit.isMove &&
//                                 favoriteCubit.hoveredIndex == index
//                             ? Container(
//                                 height: mediaQuery.height / 5,
//                                 width: mediaQuery.width,
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 5),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white12,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               )
//                             : BoardWidget(
//                                 allBoardsCubit: allBoardsCubit,
//                                 favoriteCubit: favoriteCubit,
//                                 addBoardCubit: addBoardCubit,
//                                 currentBoard: item,
//                                 currentIndex: index,
//                               ).animate().fade(
//                                   duration: const Duration(milliseconds: 500),
//                                 );
//                       },
//                     ),
//                   ),
//                   noItemsFoundIndicatorBuilder: (context) => SizedBox(
//                     height: mediaQuery.height,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         NoData(
//                           iconData: Icons.favorite_sharp,
//                           text: S
//                               .of(context)
//                               .add_your_boards_to_favorites_to_see_them_here,
//                         ),
//                       ],
//                     ),
//                   ).animate().fade(
//                         duration: const Duration(milliseconds: 500),
//                       ),
//                   firstPageProgressIndicatorBuilder: (context) =>
//                       const BoardShimmer(),
//                   newPageProgressIndicatorBuilder: (context) =>
//                       const BoardShimmer(),
//                 ),
//               );
//             },
//           );
//         });
//       }),
//     );
//   }
// }
