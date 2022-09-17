// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tile_state.dart';

class BoardTile extends StatelessWidget {

  final double tileDimension;
  final VoidCallback onPressed;
  final TileState tileState;
  
  const BoardTile(
    {Key? key,
    required this.tileState,
    required this.tileDimension,
    required this.onPressed}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:tileDimension,
      height: tileDimension,
      child: FlatButton(    //deprecated member
        onPressed:onPressed,
        child: _widgetForTile(),
      ),
    );
  }
  Widget _widgetForTile(){
    Widget widget;
    switch(tileState){
      case TileState.EMPTY:
      {
        widget=Container();
      }
      break;
      case TileState.CIRCLE:
      {
        widget=Image.asset('images/o.png');
      }
      break;
      case TileState.CROSS:
      {
        widget=Image.asset('images/x.png');
      }
      break;
    }
    return widget;
  }
}