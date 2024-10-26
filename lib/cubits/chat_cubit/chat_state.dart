part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatEditData extends ChatState {}

final class ChatAudioRecording extends ChatState {}

final class ChatMediaPicked extends ChatState {}

final class ChatMessageChanged extends ChatState {}

final class ChatMessageSent extends ChatState {}

final class ChatAudioStateChanged extends ChatState {}

final class ChatRecordingStarted extends ChatState {}

// final class ChatScreenRecording extends ChatState {
//   final RecordOutput response;

//   ChatScreenRecording({required this.response});
// }

final class ChatScreenRecordingStarted extends ChatState {}

final class ChatRecordingStopped extends ChatState {}

final class ChatAudioStopped extends ChatState {}

final class ChatVideoClosed extends ChatState {}

final class ChatVideoOpened extends ChatState {
  final String videoPath;
  final String thumbnailPath;

  ChatVideoOpened({required this.videoPath, required this.thumbnailPath});
}

final class ChatAudioPlaying extends ChatState {
  final String audioPath;

  ChatAudioPlaying({required this.audioPath});
}

final class ChatScreenRecordingStopped extends ChatState {
  final String path;
  final String thumbnailPath;
  ChatScreenRecordingStopped({required this.path, required this.thumbnailPath});
}

final class ChatRecordingError extends ChatState {
  final String message;

  ChatRecordingError({required this.message});
}

final class ChatVideoRecorded extends ChatState {
  final String path;

  ChatVideoRecorded({required this.path});
}

final class ChatAudioRecorded extends ChatState {
  final String path;

  ChatAudioRecorded({required this.path});
}

class ChatEmojiKeyboardShown extends ChatState {}

class ChatEmojiKeyboardHidden extends ChatState {}

class ChatLocaleChanged extends ChatState {
  final String? localeCode;
  ChatLocaleChanged(this.localeCode);
}

//State for chat Get Messages
class FetchChatMessagesLoading extends ChatState {}

class FetchChatMessagesSuccess extends ChatState {
  List<ChatMessageModel> newMessages;
  final bool isReachMax;

  FetchChatMessagesSuccess({
    required this.isReachMax,
    required this.newMessages,
  });
}

class FetchChatMessagesFailure extends ChatState {
  final String errorMessage;

  FetchChatMessagesFailure({required this.errorMessage});
}

class FetchChatMessagesExpiredToken extends ChatState {}

class FetchChatMessagesServerError extends ChatState {}

class FetchChatMessagesNoINternet extends ChatState {}

//State for chat Get Messages
class SendMessagesLoading extends ChatState {}

class SendMessagesSuccess extends ChatState {
  final ChatMessageModel chat;

  SendMessagesSuccess({required this.chat});
}

class SendMessagesFailure extends ChatState {
  final String errorMessage;

  SendMessagesFailure({required this.errorMessage});
}

class SendMessagesExpiredToken extends ChatState {}

//Reply Message State

class ChatReplying extends ChatState {
  final ChatMessageModel message;

  ChatReplying({required this.message});
}

class ChatReplyCancelled extends ChatState {}
