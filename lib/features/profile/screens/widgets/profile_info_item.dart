import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem({
    super.key,
    required this.text,
    this.onTap,
    required this.icon,
    this.suffixWidget,
  });

  final String text;
  final void Function()? onTap;
  final IconData icon;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 16.0),
          Text(text, style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          suffixWidget ??
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ],
      ),
    );
  }
}
