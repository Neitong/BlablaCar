import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class FormPicker extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showSwapIcon;
  final String? value;
  final VoidCallback? onSwap;

  const FormPicker({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showSwapIcon = false,
    this.value,
    this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null;
    final IconData displayIcon = hasValue ? Icons.check_circle : icon;
    final Color iconColor = hasValue ? BlaColors.primary : BlaColors.neutralLight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
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
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}