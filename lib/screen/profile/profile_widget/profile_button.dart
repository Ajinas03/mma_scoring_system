// widgets/profile_list_tile_button.dart
import 'package:flutter/material.dart';

class ProfileListTileButton extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subtitle;
  final IconData? trailingIcon;
  final VoidCallback onTap;
  final Color? iconColor;

  const ProfileListTileButton({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailingIcon = Icons.arrow_forward_ios,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: iconColor ?? Theme.of(context).primaryColor,
          size: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )
            : null,
        trailing: Icon(
          trailingIcon,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
