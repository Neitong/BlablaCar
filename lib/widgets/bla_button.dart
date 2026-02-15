import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum BlaButtonType {
  primary,
  secondary,
}

class BlaButton extends StatelessWidget {

  final String text;
  final BlaButtonType type;
  final IconData? icon;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    final bool isPrimary = type == BlaButtonType.primary;

    final Color backgroundColor = isDisabled
        ? BlaColors.disabled
        : (isPrimary ? BlaColors.primary : BlaColors.white);

    final Color textColor = isDisabled
        ? BlaColors.neutralLight
        : (isPrimary ? BlaColors.white : BlaColors.primary);

    final Color borderColor = isDisabled
        ? BlaColors.disabled
        : (isPrimary ? BlaColors.primary : BlaColors.primary);

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: BlaColors.disabled,
          disabledForegroundColor: BlaColors.neutralLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
            side: BorderSide(
              color: borderColor,
              width: isPrimary ? 0 : 2,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: BlaSpacings.l,
            vertical: BlaSpacings.m,
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              SizedBox(width: BlaSpacings.s),
            ],
            Text(
              text,
              style: BlaTextStyles.button.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}