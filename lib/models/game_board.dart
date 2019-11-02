import 'dart:math';

import 'cell.dart';

class GameBoard {
  int numberOfRow;
  int numberOfColumn;
  int numberOfBombs;
  List<List<Cell>> cells;

  GameBoard(this.numberOfRow, this.numberOfColumn, this.numberOfBombs) {
    cells = new List();
    for (var i = 0; i < numberOfRow; i++) {
      List<Cell> columns = new List();
      for (var j = 0; j < numberOfColumn; j++) {
        Cell cell = Cell(type: CellType.facingDown);
        columns.add(cell);
      }
      cells.add(columns);
    }
  }

  void initializeGame() {
    _addMines();
    _setTypeForEachCell();
  }

  _addMines() {
    var currentNumberOfMines = 0;
    while (currentNumberOfMines < numberOfBombs) {
      var random = Random().nextInt(numberOfRow * numberOfColumn);
      int r = (random / numberOfColumn).floor();
      int c = random % numberOfColumn;
      if (cells[r][c].type != CellType.bomb) {
        cells[r][c].type = CellType.bomb;
        currentNumberOfMines++;
      }
    }
  }

  _setTypeForEachCell() {
    for (var row = 0; row < numberOfRow; row++) {
      for (var column = 0; column < numberOfColumn; column++) {
        if (cells[row][column].type == CellType.bomb) {
          continue;
        }
        cells[row][column].setType(_findSurroundedMines(row, column));
      }
    }
  }

  _findSurroundedMines(row, column) {
    int numberOfMinesSurround = 0;
    // Visiting above row
    if (row > 0) {
      if (cells[row - 1][column].hasBomb()) {
        numberOfMinesSurround++;
      }
      if (column > 0) {
        if (cells[row - 1][column - 1].hasBomb()) {
          numberOfMinesSurround++;
        }
      }
      if (column < numberOfColumn - 1) {
        if (cells[row - 1][column + 1].hasBomb()) {
          numberOfMinesSurround++;
        }
      }
    }
    // Visiting below row
    if (row < numberOfRow - 1) {
      if (cells[row + 1][column].hasBomb()) {
        numberOfMinesSurround++;
      }
      if (column > 0) {
        if (cells[row + 1][column - 1].hasBomb()) {
          numberOfMinesSurround++;
        }
      }
      if (column < numberOfColumn - 1) {
        if (cells[row + 1][column + 1].hasBomb()) {
          numberOfMinesSurround++;
        }
      }
    }
    // Check current row
    if (column > 0) {
      if (cells[row][column - 1].hasBomb()) {
        numberOfMinesSurround++;
      }
    }
    if (column < numberOfColumn - 1) {
      if (cells[row][column + 1].hasBomb()) {
        numberOfMinesSurround++;
      }
    }
    return numberOfMinesSurround;
  }
}