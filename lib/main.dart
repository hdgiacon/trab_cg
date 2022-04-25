import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false
  ));
}

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2e2e2e),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Trab de CG",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 2.0
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
                )
              )
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    CustomPaint(
                      size: const Size(500.0, 500.0),
                      painter: MyPainter()
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.lines;
    final points = [
      const Offset(0, 0),
      const Offset(0, 100),

      const Offset(0, 100),
      const Offset(100, 100),

      const Offset(100, 100),
      const Offset(100, 0),

      const Offset(100, 0),
      const Offset(0, 0),

      const Offset(0, 0),
      const Offset(50, -50),

      const Offset(100, 0),
      const Offset(150, -50),

      const Offset(50, -50),
      const Offset(150, -50),

      const Offset(100, 100),
      const Offset(150, 50),

      const Offset(150, 50),
      const Offset(150, -50),
    ];
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
