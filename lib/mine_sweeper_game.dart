import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/game_board.dart';
import 'widgets/cell_widget.dart';

class MineSweeperGame extends StatefulWidget {
  @override
  _MineSweeperGameState createState() {
    return _MineSweeperGameState();
  }
}

class _MineSweeperGameState extends State<MineSweeperGame> {
  int numberOfRow;
  int numberOfColumn;
  int numberOfMine;
  GameBoard gameBoard;

  @override
  void initState() {
    super.initState();
    numberOfRow = 8;
    numberOfColumn = 10;
    numberOfMine = 15;
    // initialize cell
    initialize();
  }

  initialize() {
    gameBoard = new GameBoard(numberOfRow, numberOfColumn, numberOfMine);
    gameBoard.initializeGame();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mine Sweeper"),
      ),
      body: Column(children: <Widget>[
        Container(
          color: Colors.indigo[100],
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '${gameBoard.numberOfRemainingCells.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontFamily: "CursedTimer",
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 40))
                  ]),
              Column(
                children: <Widget>[
                  SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: FlatButton(
                          onPressed: () => initialize(),
                          child: gameBoard.gameOver
                              ? Image.asset('assets/images/sadFace.png')
                              : Image.asset('assets/images/happyFace.png'))),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '${gameBoard.numberOfRevealedCells.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontFamily: "CursedTimer",
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 40))
                  ]),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.black, width: 2.0)
//              ),
            child: GridView.builder(
//                scrollDirection: Axis.horizontal,
              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberOfColumn,
              ),
              itemBuilder: _buildGridItems,
              itemCount: numberOfRow * numberOfColumn,
            ),
          ),
        ),
        Container(
          color: Colors.indigo[100],
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  onPressed: () => _handleRevealAll(), child: Text("Reveal")),
              FlatButton(onPressed: () => _handleHideAll(), child: Text("Hide"))
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
//    int gridStateLength = 4;
    int x, y = 0;
    x = (index / numberOfColumn).floor();
    y = index % numberOfColumn;

//    print("row $row");
//    print("column $column");
//    print("index $index");
//    print("x $x");
    print("index [$index, $x, $y]");
    return GestureDetector(
      onTap: () => _handleCellTapped(x, y),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    return CellWidget(cell: gameBoard.cells[x][y]);
  }

  _handleCellTapped(x, y) {
    gameBoard.revealCell(x, y);
    setState(() {});
  }

  _handleRevealAll() {
    gameBoard.revealAll();
    setState(() {});
  }

  _handleHideAll() {
    gameBoard.hideAll();
    setState(() {});
  }
}
