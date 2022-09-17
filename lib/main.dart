
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
  final _boardState = List.filled(9, TileState.EMPTY);
  var _currentTurn=TileState.CROSS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(children: [
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
                    onPressed: ()=>_updateTileStateForIndex(tileIndex),
                    );
              }).toList(),
            );
          }).toList()));
    });
  }

  void _updateTileStateForIndex(int selectedIndex){
    if(_boardState[selectedIndex]==TileState.EMPTY){
      setState(() {
          _boardState[selectedIndex]=_currentTurn;
          _currentTurn=_currentTurn==TileState.CROSS?TileState.CIRCLE:TileState.CROSS;
      });
    }
  }
}
