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
  int numberOfRows;
  int numberOfColumns;
  int numberOfMines;
  GameBoard gameBoard;

  // Temporary values
  String numberOfRowsText;
  String numberOfColumnsText;
  String numberOfMinesText;

  @override
  void initState() {
    super.initState();

    // Default values
    numberOfRows = 8;
    numberOfColumns = 10;
    numberOfMines = 15;
    numberOfRowsText = '';
    numberOfColumnsText = '';
    numberOfMinesText = '';

    // initialize cell
    initialize();
  }

  initialize() {
    // reset the configuration if there are values set
    if(numberOfRowsText.isNotEmpty && numberOfColumnsText.isNotEmpty && numberOfMinesText.isNotEmpty){
      numberOfRows = int.parse(numberOfRowsText);
      numberOfColumns = int.parse(numberOfColumnsText);
      numberOfMines = int.parse(numberOfMinesText);
    }

    gameBoard = new GameBoard(numberOfRows, numberOfColumns, numberOfMines);
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
//              ),
            child: GridView.builder(
//              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberOfColumns,
              ),
              itemBuilder: _buildGridItems,
              itemCount: numberOfRows * numberOfColumns,
            ),
          ),
        ),
        Container(
          color: Colors.indigo[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                    width: 100,
                    child: TextField(
                      onChanged: (text) {
                        this.numberOfRowsText = text;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Row count',
                        helperText: "Number of rows",
                        labelText: "Rows",
                      ),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
                      width: 100,
                      child: TextField(
                        onChanged: (text) {
                          this.numberOfColumnsText = text;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Column count',
                          helperText: "Number of columns",
                          labelText: "Column",
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SizedBox(
                      width: 100,
                      child: TextField(
                        onChanged: (text) {
                          this.numberOfMinesText = text;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Bombs count',
                          helperText: "Number of bombs",
                          labelText: "Bombs",
                        ),
                      )))
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
//    int gridStateLength = 4;
    int x, y = 0;
    x = (index / numberOfColumns).floor();
    y = index % numberOfColumns;

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
}
