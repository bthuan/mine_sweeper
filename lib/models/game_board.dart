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

  void revealCell(x, y) {
    // Do nothing if this cell is revealed
    if (!cells[x][y].hidden) {
      return;
    }

    cells[x][y].hidden = false;

    // if this cell is empty -> reveal adjacent cells
    if (cells[x][y].type == CellType.zero) {
      // Find all adjacent cells first
      if (x > 0) {
        if (y > 0) {
          revealCell(x - 1, y - 1);
        }
        if (y < numberOfColumn - 1) {
          revealCell(x - 1, y + 1);
        }
        revealCell(x - 1, y);
      }
      if (x < numberOfRow - 1) {
        if (y > 0) {
          revealCell(x + 1, y - 1);
        }
        if (y < numberOfColumn - 1) {
          revealCell(x + 1, y + 1);
        }
        revealCell(x + 1, y);
      }
      if (y > 0) {
        revealCell(x, y - 1);
      }
      if (y < numberOfColumn - 1) {
        revealCell(x, y + 1);
      }
    }
  }

  revealAll() {
    for (var row = 0; row < numberOfRow; row++) {
      for (var column = 0; column < numberOfColumn; column++) {
        cells[row][column].hidden = false;
      }
    }
  }

  hideAll() {
    for (var row = 0; row < numberOfRow; row++) {
      for (var column = 0; column < numberOfColumn; column++) {
        cells[row][column].hidden = true;
      }
    }
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
