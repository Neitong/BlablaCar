import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BookingSeatScreen extends StatefulWidget {
  final int initialSeats;

  const BookingSeatScreen({super.key, required this.initialSeats});

  @override
  State<BookingSeatScreen> createState() => _BookingSeatScreenState();
}

class _BookingSeatScreenState extends State<BookingSeatScreen> {
  late int seats;

  @override
  void initState() {
    super.initState();
    seats = widget.initialSeats;
  }

  void _decrement() {
    if (seats > 1) {
      setState(() {
        seats--;
      });
    }
  }

  void _increment() {
    setState(() {
      seats++;
    });
  }

  void _confirm() {
    Navigator.pop(context, seats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: BlaColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirm,
        backgroundColor: BlaColors.primary,
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: BlaSpacings.l),
              Text('Number of seats to book', style: BlaTextStyles.heading, textAlign: TextAlign.center),
              const SizedBox(height: BlaSpacings.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 32),
                    onPressed: seats > 1 ? _decrement : null,
                    color: BlaColors.primary,
                  ),
                  const SizedBox(width: BlaSpacings.l),
                  Text(
                    '$seats',
                    style: BlaTextStyles.heading,
                  ),
                  const SizedBox(width: BlaSpacings.l),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 32),
                    onPressed: _increment,
                    color: BlaColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
