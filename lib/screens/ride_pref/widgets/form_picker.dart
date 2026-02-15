import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

Widget formPicker({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  bool showSwapIcon = false,
  String? value,
  VoidCallback? onSwap,
}) {

  final bool hasValue = value != null;
  final IconData displayIcon = hasValue ? Icons.check_circle : icon;
  final Color iconColor = hasValue ? BlaColors.primary : BlaColors.neutralLight;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m, vertical: BlaSpacings.m,
      ),

      child: Row(
        children: [
          Icon(
            displayIcon,
            color: iconColor,
            size: 24,
          ),
          SizedBox(width: BlaSpacings.m),
          Expanded(
            child: Text(
              value ?? label,
              style: BlaTextStyles.body.copyWith(
                color: value == null
                  ? BlaColors.neutralLight
                  : BlaColors.neutralDark,
              ),
            ),
          ),
          if (showSwapIcon)
            GestureDetector(
              onTap: onSwap,
              child: Icon(
                Icons.swap_vert, 
                color: BlaColors.primary, 
                size: 24
              ),
            ),
        ],
      ),
    ),
  );
}