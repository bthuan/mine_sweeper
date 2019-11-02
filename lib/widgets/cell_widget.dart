import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;

  CellWidget({this.cell});

  Image getImage(Cell cell){
    if(cell.hidden){
      return Image.asset('assets/images/facingDown.png');
    } else {
      switch(cell.type){
        case CellType.bomb:
          return Image.asset('assets/images/bomb.png');
        case CellType.zero:
          return Image.asset('assets/images/0.png');
        case CellType.one:
          return Image.asset('assets/images/1.png');
        case CellType.two:
          return Image.asset('assets/images/2.png');
        case CellType.three:
          return Image.asset('assets/images/3.png');
        case CellType.four:
          return Image.asset('assets/images/4.png');
        case CellType.five:
          return Image.asset('assets/images/5.png');
        case CellType.six:
          return Image.asset('assets/images/6.png');
        case CellType.seven:
          return Image.asset('assets/images/7.png');
        case CellType.eight:
          return Image.asset('assets/images/8.png');

        default:
          return Image.asset('assets/images/facingDown.png');
      }
    }

  }

  Widget build(context) {
    return Container(
      color: Colors.yellow,
      child: getImage(this.cell),
    );
  }
}
