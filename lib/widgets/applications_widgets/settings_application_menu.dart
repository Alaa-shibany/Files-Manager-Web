import 'package:flutter/material.dart';
import 'package:files_manager/generated/l10n.dart';

// ignore: must_be_immutable
class SettingsApplicationMenu extends StatelessWidget {
  SettingsApplicationMenu({super.key, required this.onSelected});
  void Function(String)? onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                const Icon(Icons.settings, color: Colors.white),
                const SizedBox(width: 10),
                Text(S.of(context).settings),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'copy',
            child: Row(
              children: [
                const Icon(Icons.copy, color: Colors.white),
                const SizedBox(width: 10),
                Text(S.of(context).copy),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'history',
            child: Row(
              children: [
                const Icon(Icons.history, color: Colors.white),
                const SizedBox(width: 10),
                Text(S.of(context).revision_history),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(Icons.delete, color: Colors.white),
                const SizedBox(width: 10),
                Text(S.of(context).delete),
              ],
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
