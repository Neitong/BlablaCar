import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';
import './location_tiles.dart';

class LocationPicker extends StatefulWidget {
  
  final List<Location> locations;
  final Location? selected;
  final void Function(Location)? onLocationSelected;
  final String label;

  const LocationPicker({
    super.key,
    this.selected,
    required this.locations,
    this.onLocationSelected,
    required this.label,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class LocationPickerResult {
  final Location? location;
  final bool cleared;

  // Constructors
  const LocationPickerResult._({required this.location, required this.cleared});
  const LocationPickerResult.selected(Location location) : this._(location: location, cleared: false);
  const LocationPickerResult.cleared() : this._(location: null, cleared: true);
}

class _LocationPickerState extends State<LocationPicker> {
  
  late List<Location> filteredLocations;
  late TextEditingController _searchController;
  
  String search = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.selected?.name ?? '',
    );
    search = _searchController.text;
    filteredLocations = _filterLocations(search);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Location> _filterLocations(String locationSearched) {
    return widget.locations.where((l) => l.name
              .toLowerCase()
              .contains(locationSearched.toLowerCase()),
        ).toList();
  }

  void _onSearchChanged(String locationSearched) {
    setState(() {
      search = locationSearched;
      filteredLocations = _filterLocations(locationSearched);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: BlaColors.greyLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: BlaSpacings.s),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search ${widget.label} location',
                    border: InputBorder.none,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              IconButton(
                icon: Icon(
                  (search.isNotEmpty || widget.selected != null)
                      ? Icons.clear
                      : Icons.close,
                  size: 20,
                ),
                onPressed: () {
                  if (search.isNotEmpty || widget.selected != null) {
                    _searchController.clear();
                    _onSearchChanged('');
                    return;
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: filteredLocations.length,
        itemBuilder: (context, index) {
          final location = filteredLocations[index];
          return LocationTile(
            location: location,
            onTap: () {
              widget.onLocationSelected?.call(location);
              Navigator.pop(
                context,
                LocationPickerResult.selected(location),
              );
            },
          );
        },
      ),
    );
  }
}