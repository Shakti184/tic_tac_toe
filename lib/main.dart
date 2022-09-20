
// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board_tile.dart';
import 'package:tic_tac_toe/tile_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _boardState = List.filled(9, TileState.EMPTY);
  var _currentTurn=TileState.CROSS;
  var count=0;
  final navigationKey=GlobalKey<NavigatorState>();
   bool gameHasStarted=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      home: Scaffold(
        appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0), // here the desired height
                child: Center(
                  child: AppBar(
                    backgroundColor: Colors.blueAccent,
                    centerTitle: true,
                    title: const Text("Tic-Tac-Toe " "developed by Shakti"),
                  ),
                ),
            ),
        body: Center(
          child: Stack(
            children: [
            Image.asset('images/board.png'),
            _boardTiles(),
          ],),
        ),
      ),
    );
  }

  Widget _boardTiles(){
    return Builder(builder: (context){

      final boardDimension=MediaQuery.of(context).size.width;
      final tileDimension=boardDimension/3;
      return SizedBox(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children:chunk(_boardState, 3).asMap().entries.map((entry){
            final chunkIndex=entry.key;
            final tileStateChunk=entry.value;
            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry){
                  final innerIndex=innerEntry.key;
                  final tileState = innerEntry.value;
                  final tileIndex=(chunkIndex*3)+innerIndex;
                  return BoardTile(
                    tileState: tileState,
                    tileDimension: tileDimension,
                    onPressed: (){
                        count+=1;
                      _updateTileStateForIndex(tileIndex);
                      },
                    );
              }).toList(),
            );
          }).toList()));
    });
  }

  void _updateTileStateForIndex(int selectedIndex){
    gameHasStarted=true;
    if(_boardState[selectedIndex]==TileState.EMPTY){
      setState(() {
          _boardState[selectedIndex]=_currentTurn;
          _currentTurn=_currentTurn==TileState.CROSS?TileState.CIRCLE:TileState.CROSS;
      });
      final winner = _findWinner();
      if(winner!=null){
        _showWinnerDialog(winner);
      }
    }
  }

  TileState? _findWinner() {
    // ignore: prefer_function_declarations_over_variables
    TileState? Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardState[a] != TileState.EMPTY) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
              gameHasStarted=false;
          return _boardState[a];
        }
      }
      if(count==9) return TileState.EMPTY;
      return null;
    };


    final checks=[
      winnerForMatch(0,1,2),
      winnerForMatch(3,4,5),
      winnerForMatch(6,7,8),
      winnerForMatch(0,3,6),
      winnerForMatch(1,4,7),
      winnerForMatch(2,5,8),
      winnerForMatch(0,4,8),
      winnerForMatch(2,4,6),
    ];
    TileState? winner;
    int i=0;
    for(i=0;i<=checks.length;i++){
      if(checks[i]!=null){
        winner=checks[i];
        break;
      }
    }  
    
    return winner;
  }

  void _showWinnerDialog(TileState tileState){
    final context= navigationKey.currentState!.overlay!.context;
    showDialog(
      context : context,
      builder: (_){
        return AlertDialog(
          title: const Text('Winner'),
          content: Image.asset(
            tileState==TileState.CROSS?'images/x.png':tileState==TileState.CIRCLE?'images/o.png':'images/game_over.png',
          ),
          actions: [
            FlatButton(
              onPressed: (){
                _resetGame();
                Navigator.of(context).pop();
              }, 
              child: const Text('New Game'))],
        );
      },
      );
  }
  void _resetGame(){
    setState(() {
      count=0;
      _boardState=List.filled(9, TileState.EMPTY);
      _currentTurn=TileState.CROSS;
    });
  }
}
