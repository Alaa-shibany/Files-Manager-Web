import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingSectionWidget extends StatelessWidget
    implements AbstractSettingsSection {
  const SettingSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.tiles,
  });

  final String sectionTitle;
  final List<SettingsTile> tiles;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: Text(sectionTitle),
      tiles: tiles,
    );
  }
}
