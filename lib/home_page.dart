import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var uQuestion = '';
  var uAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '=',
  ];
  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void question(int index) {
    if (index == 0) {
      setState(() {
        uQuestion = '';
      });
    } else if (index == 1) {
      if (uQuestion != '') {
        setState(() {
          uQuestion = uQuestion.substring(0, uQuestion.length - 1);
        });
      }
    } else {
      setState(() {
        uQuestion += buttons[index];
      });
    }
  }

  void equelPressed() {
    String finalQuestion = uQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      if (uQuestion.isNotEmpty) {
        uAnswer = eval.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: backGroundDecoration(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text(uQuestion)),
                    Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(uAnswer)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: buttons.length,
                    staggeredTileBuilder: (index) => index == 16
                        ? const StaggeredTile.count(2, 1)
                        : const StaggeredTile.count(1, 1),
                    itemBuilder: (BuildContext context, index) {
                      if (index == 0) {
                        // clear button
                        return CalcButton(
                            buttonTapped: () {
                              question(index);
                            },
                            buttontext: buttons[index],
                            buttoncolor:
                                const Color.fromARGB(255, 212, 212, 210),
                            textcolor: Colors.black);
                      } else if (index == 1) {
                        // delete button
                        return CalcButton(
                            buttonTapped: () {
                              question(index);
                            },
                            buttontext: buttons[index],
                            buttoncolor:
                                const Color.fromARGB(255, 212, 212, 210),
                            textcolor: Colors.black);
                      } else if (index == buttons.length - 1) {
                        // delete button
                        return CalcButton(
                            buttonTapped: () {
                              equelPressed();
                            },
                            buttontext: buttons[index],
                            buttoncolor: isOperator(buttons[index])
                                ? const Color.fromARGB(255, 15, 82, 206)
                                : const Color.fromARGB(255, 27, 27, 27),
                            textcolor: Colors.white);
                      } else {
                        // rest of the buttons
                        return CalcButton(
                            buttonTapped: () {
                              question(index);
                            },
                            buttontext: buttons[index],
                            buttoncolor: isOperator(buttons[index])
                                ? const Color.fromARGB(255, 15, 82, 206)
                                : const Color.fromARGB(255, 27, 27, 27),
                            textcolor: Colors.white);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration backGroundDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromARGB(255, 48, 49, 54),
        Color.fromARGB(255, 40, 52, 70),
        Color.fromARGB(255, 53, 58, 120),
      ],
    ));
  }
}
