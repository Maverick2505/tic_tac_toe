import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String playerSide;
  final bool isAi;
  const GameScreen({super.key, required this.playerSide, required this.isAi});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String winner = "";
  int playerScore = 0;
  int aiScore = 0;
  String playerOneName = "Jugador";
  String playerTwoName = "IA";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.playerSide == "0" && widget.isAi){
      currentPlayer = "X";
      aiMove();
    }
    if(widget.isAi == false){
      playerOneName = "Player 1";
      playerTwoName = "Player 2"; //Minuto 9:33
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}