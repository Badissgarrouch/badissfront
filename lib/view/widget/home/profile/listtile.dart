import 'package:flutter/material.dart';

Widget buildListTileWithAction({
  required BuildContext context,
  required IconData icon,
  required Color color,
  required String title,
  String? subtitle,
  required VoidCallback action,
}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    subtitle: subtitle != null
        ? Text(
      subtitle,
      style: TextStyle(
        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
      ),
    )
        : null,
    trailing: Icon(Icons.chevron_right, color: Colors.grey),
    onTap: action,
  );
}