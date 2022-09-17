// ignore_for_file: constant_identifier_names

import 'dart:math';

enum TileState{
  EMPTY,CROSS,CIRCLE
}

List<List<TileState>> chunk (List<TileState>list,int size){
  return List.generate(
    (list.length/size).ceil(),
    (index)=>
      list.sublist(index*size, 
      min(index*size+size,list.length))
  );
}