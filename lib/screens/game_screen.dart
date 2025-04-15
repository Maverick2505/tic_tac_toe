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
  String playerOneName = "Jugador 1";
  String playerTwoName = "Jugador 2";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.playerSide == "0" && widget.isAi){
      currentPlayer = "X";
      aiMove();
    }
    if(widget.isAi == false) {
      playerOneName = "Player 1";
      playerTwoName = "Player 2"; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
           child: Row(
            children: [
              Text(
                playerOneName,
                style: TextStyle(fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 30,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  "$playerScore - $aiScore",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                ),
                Text(
                  playerTwoName,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
            ],
            ), 
          ),
          SizedBox(height: 20,),
          Card(

            color: Colors.white,
            elevation : 5,
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
                  ),
                itemCount: 9,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()=> makeMove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < 6?
                              BorderSide(width: 2,color:Colors.green): BorderSide.none,
                          right: index < 9 && index % 3 != 2?
                              BorderSide(width: 2, color: Colors.red): BorderSide.none,
                        )
                      ),
                      child: Center(
                        child: board[index]== "X"
                        ? Image.asset("assets/dinoco.png",width: 80,)
                        : board[index]== "0" ?
                        Image.asset("assets/rusteze.png",width: 80,): null,
                      ),
                    ),
                  );
                }
                ),
              ),
          ),
          SizedBox(height: 20,),
          Text(winner, style: TextStyle(fontSize: 24, color: Colors.red)),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200,50),
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,
              shadowColor: Colors.blueGrey
            ),
            onPressed: resetBoard, 
            child: Text(
              "Reiniciar Juego",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            )
            )
        ],
      )
    );
  }
  
  void aiMove() {
    for(int i = 0; i<9; i++){
      if(board[i]== ""){
        board[i]= currentPlayer;
        if(checkWinner(currentPlayer)) {
          setState(() {
            winner = "$currentPlayer Gana!";
            aiScore++;
          });
          return;
        }
        board[i]= "";
      }
    }
    String opponent = widget.playerSide;
    for(int i = 0; i<9; i++){
      if(board[i]==""){
        board[i] = opponent;
        if(checkWinner(opponent)){
          setState(() {
            board[i] = currentPlayer;
          });
          currentPlayer = currentPlayer == "X" ? "0" : "X";
          return;
        }
        board[i] = "";
      }
    }
    if(board[4]==""){
      setState(() {
        board[4]=currentPlayer;
        currentPlayer=currentPlayer == "X" ? "0" : "X";
      });
      return;
    }
    List<int> corners = [0,2,6,8];
    for(int corner in corners){
      if(board[corner]==""){
        setState(() {
          board[corner] = currentPlayer;
          currentPlayer = currentPlayer == "X" ? "0" : "X";
        });
        return;
      }
    }
  }
  bool checkWinner(String player){
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for(var pattern in winPatterns){
      if(board[pattern[0]]== player &&
         board[pattern[1]]== player &&
         board[pattern[2]]== player){
        return true;
      }
    }
    return false;
  }
  
  void makeMove(int index) {
    if(board[index]== "" && winner == ""){
      setState(() {
        board[index]= currentPlayer;
        if(checkWinner(currentPlayer)){
          winner = "$currentPlayer Gana!";
          if(currentPlayer == widget.playerSide){
            playerScore ++;
          } else{
            aiScore ++;
          }
        } else if(!board.contains("")){
          winner = "Empate!";
        }else{
          currentPlayer = currentPlayer == "X" ? "0": "X";
          if(widget.isAi && currentPlayer != widget.playerSide){
            aiMove();
          }
        }
      });
    }
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9,"");
      winner = "";
      currentPlayer = widget.playerSide == "0" ? "X": "X";
      if(widget.playerSide == "0" && widget.isAi){
        aiMove();
      }
    });
  }
}