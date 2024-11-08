import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/functions/statics.dart';
import '../../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../../cubits/application_cubit/application_cubit.dart';
import '../../cubits/board_cubit/board_cubit.dart';
import '../../models/file_model.dart';
import '../../models/member_model.dart';
import '../../theme/color.dart';

class FileWidget extends StatelessWidget {
  const FileWidget(
      {super.key,
      required this.mediaQuery,
      required this.allBoardsCubit,
      required this.boardCubit,
      required this.index,
      required this.applicationCubit});
  final Size mediaQuery;
  final AllBoardsCubit allBoardsCubit;
  final BoardCubit boardCubit;
  final int index;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          Statics.isPlatformDesktop ? mediaQuery.width / 3 : mediaQuery.width,
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            boardCubit.currentBoard.allFiles[index].getIcon(),
            color: Colors.blueGrey,
          ),
          subtitle: SizedBox(
            height: mediaQuery.height / 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                boardCubit.currentBoard.allFiles[index].getApplicationOwner() !=
                        null
                    ? Text('Booked by', style: TextStyle(color: Colors.red))
                    : Text(
                        'Free for editing',
                        style: TextStyle(color: Colors.green),
                      ),
                SizedBox(
                  width: mediaQuery.width / 90,
                ),
                boardCubit.currentBoard.allFiles[index].getApplicationOwner() !=
                        null
                    ? memberWidget(
                        member: boardCubit.currentBoard.allFiles[index]
                            .getApplicationOwner()!,
                        mediaQuery: mediaQuery)
                    : const SizedBox()
              ],
            ),
          ),
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'checkout') {
                await boardCubit.checkOut(
                    file: boardCubit.currentBoard.allFiles[index] as FileModel);
              } else if (value == 'checkIn') {
                await boardCubit.checkIn(
                    file: boardCubit.currentBoard.allFiles[index] as FileModel);
              } else if (value == 'share') {
                print('Share');
                // share();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: boardCubit.currentBoard.allFiles[index]
                            .getApplicationOwner() !=
                        null
                    ? 'checkout'
                    : 'checkIn',
                child: ListTile(
                  leading: Icon(boardCubit.currentBoard.allFiles[index]
                              .getApplicationOwner() !=
                          null
                      ? Icons.done_all
                      : Icons.check_circle_rounded),
                  title: boardCubit.currentBoard.allFiles[index]
                              .getApplicationOwner() !=
                          null
                      ? Text(
                          'Check out',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Check in',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(
                    'Share',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'copy',
                child: ListTile(
                  leading: const Icon(Icons.copy),
                  title: Text(
                    'Copy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          title: SizedBox(
            width: Statics.isPlatformDesktop
                ? mediaQuery.width / 3.5
                : mediaQuery.width / 1.5,
            child: Text(
                boardCubit.currentBoard.allFiles[index].getApplicationName()),
          ),
        ),
      ).animate().fade(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }

  Widget memberWidget({required Member member, required Size mediaQuery}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        (member.image.isEmpty || member.image == '')
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Statics.isPlatformDesktop
                      ? mediaQuery.width / 150
                      : mediaQuery.width / 50,
                  vertical: Statics.isPlatformDesktop
                      ? mediaQuery.width / 200
                      : mediaQuery.height / 90,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: Text(
                  member.firstName[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ClipOval(
                child: CachedNetworkImage(
                  imageUrl: member.image,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: mediaQuery.width / 8, // Adjust the size as needed
                      height: mediaQuery.width / 8, // Adjust the size as needed
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: mediaQuery.width / 8, // Adjust the size as needed
                  height: mediaQuery.width / 8, // Adjust the size as needed
                ),
              ),
        if (member.role == 'admin')
          Positioned(
            bottom: Statics.isPlatformDesktop ? 2 : -1,
            right: -mediaQuery.width / 90,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 170,
                  vertical: mediaQuery.height / 150),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: Statics.isPlatformDesktop
                    ? mediaQuery.width / 150
                    : mediaQuery.width / 40,
              ),
            ),
          ),
      ],
    );
  }
}
