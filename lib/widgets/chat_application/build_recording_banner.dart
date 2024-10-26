import 'package:flutter/material.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/generated/l10n.dart';

class BuildRecordingBanner extends StatelessWidget {
  const BuildRecordingBanner({super.key, required this.chatCubit});
  final ChatCubit chatCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chatCubit.isRecordingAudio
                ? '${S.of(context).audio_recording_in_progress}...'
                : '${S.of(context).screen_recording_in_progress}...',
            style: const TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () async {
              if (chatCubit.isRecordingAudio) {
                await chatCubit.stopAudioRecording(context);
              } else if (chatCubit.isRecordingScreen) {
                await chatCubit.stopScreenRecording(context);
              }
            },
            child: Text(S.of(context).stop_recording),
          ),
        ],
      ),
    );
  }
}
