// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
// import 'package:files_manager/cubits/notes_cubit/notes_cubit.dart';
// import 'package:files_manager/widgets/applications_widgets/settings_application_menu.dart';
// import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';

// class NotesApplicationScreen extends StatefulWidget {
//   const NotesApplicationScreen({super.key, required this.boardCubit});
//   final BoardCubit boardCubit;

//   @override
//   _NotesApplicationScreenState createState() => _NotesApplicationScreenState();
// }

// class _NotesApplicationScreenState extends State<NotesApplicationScreen> {
//   quill.QuillController controller = quill.QuillController.basic();

//   @override
//   Widget build(BuildContext context) {
//     final todoCubit = context.read<NotesCubit>();
//     final mediaQuery = MediaQuery.of(context).size;

//     return WillPopScope(
//       onWillPop: () async {
//         await widget.boardCubit.refresh();
//         return true;
//       },
//       child: BlocConsumer<NotesCubit, NotesState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               title: CustomTextFields(
//                 controller: todoCubit.taskTitleController,
//                 onChanged: (p0) async {
//                   await todoCubit.editTaskName();
//                 },
//               ),
//               centerTitle: true,
//               actions: const [SettingsApplicationMenu()],
//             ),
//             body: Column(
//               children: [
//                 quill.QuillToolbar.simple(controller: controller),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     child: quill.QuillEditor.basic(
//                       controller: controller,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
