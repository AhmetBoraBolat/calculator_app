import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String buttontext;
  final Color buttoncolor;
  final Color textcolor;
  final VoidCallback buttonTapped;

  const CalcButton(
      {super.key,
      required this.buttontext,
      required this.buttoncolor,
      required this.textcolor,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: buttoncolor,
            child: Center(
                child: Text(
              buttontext,
              style: TextStyle(color: textcolor, fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }
}
