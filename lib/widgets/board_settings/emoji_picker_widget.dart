// import 'package:flutter/material.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// class EmojiPickerExample extends StatefulWidget {
//   @override
//   _EmojiPickerExampleState createState() => _EmojiPickerExampleState();
// }

// class _EmojiPickerExampleState extends State<EmojiPickerExample> {
//   TextEditingController _controller = TextEditingController();
//   bool _isEmojiVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Emoji Picker Example'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(hintText: 'Type something...'),
//             ),
//           ),
//           // Toggle button to show or hide emoji picker
//           IconButton(
//             icon: Icon(Icons.emoji_emotions),
//             onPressed: () {
//               setState(() {
//                 _isEmojiVisible = !_isEmojiVisible;
//               });
//             },
//           ),
//           Offstage(
//             offstage: !_isEmojiVisible,
//             child: SizedBox(
//               height: 250,
//               child: EmojiPicker(
//                 onEmojiSelected: (Category? category, Emoji emoji) {
//                   _controller.text += emoji.emoji;
//                 },
//                 onBackspacePressed: () {
//                   _controller.text = _controller.text.characters.skipLast(1).toString();
//                 },
//                 config: Config(
//                   emojiSet: [
//                     CategoryEmoji(Category.ANIMALS, [
//                       Emoji('smile', 'ss')
//                     ])
//                   ],
//                   columns: 7,
//                   emojiSizeMax: 32, // Adjust emoji size
//                   verticalSpacing: 0,
//                   horizontalSpacing: 0,
//                   initCategory: Category.SMILEYS,
//                   bgColor: Color(0xFFF2F2F2),
//                   indicatorColor: Colors.blue,
//                   iconColor: Colors.grey,
//                   iconColorSelected: Colors.blue,
//                   backspaceColor: Colors.blue,
//                   skinToneDialogBgColor: Colors.white,
//                   enableSkinTones: true,
//                   showRecentsTab: true,
//                   recentsLimit: 28,
//                   noRecents: const Text(
//                     'No Recents',
//                     style: TextStyle(fontSize: 20, color: Colors.black26),
//                     textAlign: TextAlign.center,
//                   ),
//                   categoryIcons: const CategoryIcons(),
//                   buttonMode: ButtonMode.MATERIAL,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
