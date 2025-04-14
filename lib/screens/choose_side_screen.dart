import 'package:flutter/material.dart';

class ChooseSideScreen extends StatefulWidget {
  final bool isAi;
  const ChooseSideScreen({super.key, required this.isAi});

  @override
  State<ChooseSideScreen> createState() => _ChooseSideScreenState();
}

class _ChooseSideScreenState extends State<ChooseSideScreen> {
  String selectedSide = "X";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Escoge tu lado",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/dinoco.png",
                      width: 150, fit: BoxFit.cover,),
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          value: "X", 
                          groupValue: selectedSide, 
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              selectedSide= value!;
                            });
                          },
                          ),
                        )
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Image.asset(
                      "assets/rusteze.png",
                      width: 150, fit: BoxFit.cover,),
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          value: "0", 
                          groupValue: selectedSide, 
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              selectedSide= value!;
                            });
                          },
                          ),
                        )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 
}