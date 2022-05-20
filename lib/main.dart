import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:core';
import 'package:ml_linalg/linalg.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false
  ));
}

Matrix objWCS = Matrix.fromList([
  [0.0, 0.0, 0.0, 0.0, 0.0],
  [0.0, 0.0, 0.0, 0.0, 0.0]
]);

class Home extends StatefulWidget {

  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   @override
  Widget build(BuildContext context) {

    // ponto de vista (a, b, c)
    TextEditingController controllerA = TextEditingController();
    TextEditingController controllerB = TextEditingController();
    TextEditingController controllerC = TextEditingController();

    /* pontos do vetor normal (P1, P2, P3) */

    // P1 = (X1, Y1, Z1)
    TextEditingController controllerP1x = TextEditingController();
    TextEditingController controllerP1y = TextEditingController();
    TextEditingController controllerP1z = TextEditingController();

    // P2 = (X2, Y2, Z2)
    TextEditingController controllerP2x = TextEditingController();
    TextEditingController controllerP2y = TextEditingController();
    TextEditingController controllerP2z = TextEditingController();

    // P3 = (X3, Y3, Z3)
    TextEditingController controllerP3x = TextEditingController();
    TextEditingController controllerP3y = TextEditingController();
    TextEditingController controllerP3z = TextEditingController();

    // os pontos são definidos em cada coluna
    Matrix matrizObjeto = Matrix.fromList([
      [1, 7, 7, 1, 4],
      [1, 1, 1, 1, 7],
      [1, 1, 7, 7, 4],
      [1, 1, 1, 1, 1]
    ]);

    return Scaffold(
      backgroundColor: const Color(0xFF2e2e2e),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Trab de CG",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
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
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    children: <Widget>[
                      // TODO: fazer um drop down aqui
                      const SizedBox(height: 10.0),
                      const Text(
                        "Ponto de vista:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        )
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerA,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "20",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerB,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "10",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerC,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "30",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        "Definição do vetor normal:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Ponto 1:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerP1x,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "1",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerP1y,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "1",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerP1z,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "7",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Ponto 2:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerP2x,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "7",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerP2y,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "1",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              controller: controllerP2z,
                              decoration: InputDecoration(
                                hintText: "7",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Ponto 3:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerP3x,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "4",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerP3y,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "7",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: TextField(
                              controller: controllerP3z,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: "4",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange
                                  )
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      RepaintBoundary(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                            fixedSize: const Size(100.0, 60.0)
                          ),
                          child: const Text(
                            "Iniciar",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          onPressed: (){
                            int x0 = 0, y0 = 0, z0 = 0;

                            double d0, d1, d;

                            double a = double.parse(controllerA.text);
                            double b = double.parse(controllerB.text);
                            double c = double.parse(controllerC.text);


                            double x1 = double.parse(controllerP1x.text);
                            double x2 = double.parse(controllerP2x.text);
                            double x3 = double.parse(controllerP3x.text);

                            double y1 = double.parse(controllerP1y.text);
                            double y2 = double.parse(controllerP2y.text);
                            double y3 = double.parse(controllerP3y.text);

                            double z1 = double.parse(controllerP1z.text);
                            double z2 = double.parse(controllerP2z.text);
                            double z3 = double.parse(controllerP3z.text);


                            double nx = (y1 - y2) * (z3 - z2) - (y3 - y2) * (z1 - z2);

                            double ny = -((x1 - x2) * (z3 - z2) - (x3 - x2) * (z1 - z2));

                            double nz = (x1 - x2) * (y3 - y2) - (x3 - x2) * (y1 - y2);

                            //double nx = 0.0;
                            //double ny = 0.0;
                            //double nz = 1.0;

                            d0 = x0*nx + y0*ny + z0*nz;

                            d1 = a*nx + b*ny + c*nz;

                            d = d0 - d1;

                            Matrix matrizPerspectiva = Matrix.fromList([
                              [d+a*nx, a*ny, a*nz, -a*d0],
                              [b*nx, d+b*ny, b*nz, -b*d0],
                              [c*nx, c*ny, d+c*nz, -c*d0],
                              [nx, ny, nz, -d1]
                            ]);

                            matrizObjeto = matrizPerspectiva * matrizObjeto;

                            List<double> lastRow = matrizObjeto[3].toList();

                            for(dynamic r in matrizObjeto){
                              for(int k = 0; k < matrizObjeto.columnsNum; k++){
                                r[k] = r[k] / lastRow[k];
                              }
                            }

                            List<List<double>> aux = [
                              [],
                              []
                            ];

                            int cont = 0;
                            for(dynamic p in matrizObjeto){
                              for(int j = 0; j < matrizObjeto.columnsNum; j++){
                                aux[cont].add(p[j]);
                              }
                              if(cont == 1){
                                break;
                              }
                              cont++;
                            }

                            objWCS = Matrix.fromList([
                              aux[0],
                              aux[1],
                              [1.0, 1.0, 1.0, 1.0, 1.0]
                            ]);

                            double uMin = 0.0, vMin = 0.0, uMax = 512.0, vMax = 384.0;

                            double xMin = objWCS[0].min().floorToDouble();
                            double xMax = objWCS[0].max().ceilToDouble();

                            double yMin = objWCS[1].min().floorToDouble();
                            double yMax = objWCS[1].max().ceilToDouble();

                            double sx = (uMax - uMin) / (xMax - xMin);
                            double sy = (vMax - vMin) / (yMax - yMin);

                            Matrix tJV = Matrix.fromList([
                              [sx, 0.0, uMin - sx * xMin],
                              [0.0, -sy, sy * yMax + vMin],
                              [0.0, 0.0, 1.0]
                            ]);

                            setState((){
                              objWCS = tJV * objWCS;

                              for (var element in objWCS[0]) {
                                element.floorToDouble();
                              }

                              for (var element in objWCS[1]) {
                                element.floorToDouble();
                              }

                              for (var element in objWCS[2]) {
                                element.floorToDouble();
                              }
                            });
                          }
                        )
                      )
                    ],
                  ),
                )
              )
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    size: const Size(512.0, 384.0),
                    painter: MyPainter(mat: objWCS)
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}

/*
  const Offset(14, 17), V1
  const Offset(31, 17), V2
  const Offset(21, 23), V3
  const Offset(1, 23),  V4
  const Offset(17, 1),  V5
*/

class MyPainter extends CustomPainter {
  Matrix? mat;

  MyPainter({@required this.mat});

  @override
  void paint(Canvas canvas, Size size) {

    double v1X = mat![0].elementAt(0);
    double v1Y = mat![1].elementAt(0);

    double v2X = mat![0].elementAt(1);
    double v2Y = mat![1].elementAt(1);

    double v3X = mat![0].elementAt(2);
    double v3Y = mat![1].elementAt(2);

    double v4X = mat![0].elementAt(3);
    double v4Y = mat![1].elementAt(3);

    double v5X = mat![0].elementAt(4);
    double v5Y = mat![1].elementAt(4);

    const pointMode = ui.PointMode.lines;
    final points = [
      Offset(v1X, v1Y), // V1 - V2
      Offset(v2X, v2Y),

      Offset(v1X, v1Y), // V1 - V4
      Offset(v4X, v4Y),

      Offset(v1X, v1Y), // V1 - V5
      Offset(v5X, v5Y),

      Offset(v2X, v2Y), // V2 - V3
      Offset(v3X, v3Y),

      Offset(v2X, v2Y), // V2 - V5
      Offset(v5X, v5Y),

      Offset(v3X, v3Y), // V3 - V4
      Offset(v4X, v4Y),

      Offset(v3X, v3Y), // V3 - V5
      Offset(v5X, v5Y),

      Offset(v4X, v4Y),  // V4 - V5
      Offset(v5X, v5Y),
    ];
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (oldDelegate as MyPainter).mat != mat;
  }
}
