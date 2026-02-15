import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: BlaColors.greyLight, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.radio_button_unchecked,
          color: BlaColors.iconLight,
          size: 20,
        ),
        title: Text(location.name),
        subtitle: Text(
          location.country.name,
          style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: BlaColors.iconLight,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}