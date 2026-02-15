import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../widgets/bla_button.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      //Background
      SizedBox(
        width: double.infinity,
        height: 340,
        child: Image.asset(
          blablaHomeImagePath,
          fit: BoxFit.cover,
      ),
      ),

      //Foreground
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 220),

            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              
              child: Padding(
                padding: EdgeInsets.all(BlaSpacings.xl),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Request to Book Button
                    BlaButton(
                    text: 'Request to Book',
                    type: BlaButtonType.primary,
                    icon: Icons.calendar_today,
                    onPressed: () => _showSnackBar(context, 'Primary button'),
                  ),
                    SizedBox(height: BlaSpacings.s),

                      //Search Rides Button
                  BlaButton(
                    text: 'Search Rides',
                    type: BlaButtonType.secondary,
                    onPressed: null,
                    icon: Icons.search,
                  ),

                  SizedBox(height: BlaSpacings.l),
                  ],
                ),
              ),
            ),


            SizedBox(height: BlaSpacings.xxl),
          ],
        ),
      ),
      ]
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),        
      backgroundColor: BlaColors.neutralDark,
    ),
  );
}    