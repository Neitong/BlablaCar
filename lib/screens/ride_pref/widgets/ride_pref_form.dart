import 'package:blabla/utils/date_time_util.dart';
import 'package:flutter/material.dart';
 
import '../../../utils/animations_util.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

import 'form_picker.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/bla_button.dart';
import '../../../theme/theme.dart';
import './location_picker.dart';
import '../../../services/locations_service.dart';


 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;



  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO 
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
    void _onDeparturePressed() async {
      final LocationPickerResult? result = await Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          LocationPicker(
            locations: LocationsService.availableLocations,
            selected: departure,
            label: "Departure",
          ),
        ),
      );

      if (result == null) {
        return;
      }

      if (result.cleared) {
        setState(() {
          departure = null;
        });
        return;
      }

      if (result.location != null) {
        setState(() {
          departure = result.location;
        });
      }
    }

    void _onArrivalPressed() async {
      final LocationPickerResult? result = await Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          LocationPicker(
            locations: LocationsService.availableLocations,
            selected: arrival,
            label: "Arrival",
          ),
        ),
      );

      if (result == null) {
        return;
      }

      if (result.cleared) {
        setState(() {
          arrival = null;
        });
        return;
      }

      if (result.location != null) {
        setState(() {
          arrival = result.location;
        });
      }
    }



  // Bonus: BLA-008 - Implement the Date picker
  //=============================================================
  // Be able to select current date, but not past dates. 
  //The date should be ranged between current date and the next year.
  void _onDatePressed() async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime nextyear = DateTime(now.year + 1, now.month, now.day);
    final DateTime initialDate = departureDate.isBefore(today) ? today : departureDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: today, //curren
      lastDate: nextyear, //next year
    );

    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  // Bonus: BLA-007 - Implement the Seat number spinner
  //=============================================================
  // The user should be able to select the number of seats they wants.
  // [at least 1, no upper limit]. 
  //=============================================================
  void _onSeatsPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Number of passengers', style: BlaTextStyles.heading),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, size: 32),
                onPressed: requestedSeats > 1
                    ? () {
                        setDialogState(() {
                          setState(() {
                            requestedSeats--;
                          });
                        });
                      }
                    : null,
                color: BlaColors.primary,
              ),
              SizedBox(width: BlaSpacings.l),
              Text(
                '$requestedSeats',
                style: BlaTextStyles.heading,
              ),
              SizedBox(width: BlaSpacings.l),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 32),
                onPressed: () {
                  setDialogState(() {
                    setState(() {
                      requestedSeats++;
                    });
                  });
                },
                color: BlaColors.primary,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: TextStyle(color: BlaColors.primary)),
          ),
        ],
      ),
    );
  }

  void _onSwapLocation() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select  a departure or an arrival location to swap.'),
        ),
      );
    }
  }

void _onSearchPressed() {
    // Validate form
    if (departure == null || arrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both departure and arrival locations.'),
        ),
      );
      return;
    }

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    Navigator.pop(context, ridePref);
  }

 

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get date => DateTimeUtils.formatDateTime(departureDate);


  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Departure Location Picker
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Leaving from',
            value: departure?.name,
            onTap: _onDeparturePressed,
            showSwapIcon: true,
            onSwap: _onSwapLocation,
          ),
          BlaDivider(),

          // Arrival Location Picker
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Going to',
            value: arrival?.name,
            onTap: _onArrivalPressed,
            showSwapIcon: false,
            onSwap: _onSwapLocation,
          ),
          BlaDivider(),

          // Date Picker
          formPicker(
            icon: Icons.calendar_month,
            label: date,
            value: null,
            onTap: _onDatePressed,
          ),
          BlaDivider(),

            // Seats Picker
          formPicker(
            icon: Icons.person_outline,
            label: requestedSeats.toString(),
            value: null,
            onTap: _onSeatsPressed,
          ),
          const SizedBox(height: BlaSpacings.s),

          // Search Button
          BlaButton(
            text: 'Search',
            type: BlaButtonType.primary,
            onPressed: _onSearchPressed,
          ),
        ],
      ),
    );
  }
}
