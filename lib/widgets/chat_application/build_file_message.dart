import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/generated/l10n.dart';

class BuildFileMessage extends StatelessWidget {
  const BuildFileMessage(
      {super.key, required this.filePath, required this.chatCubit});
  final String filePath;
  final ChatCubit chatCubit;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<ChatCubit>().openFile(filePath);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(chatCubit.fileIcon, size: 40, color: Colors.blue),
              Text(
                S.of(context).open_file,
                style: const TextStyle(color: Colors.white),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
