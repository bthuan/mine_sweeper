class Cell {
  CellType type;
  int numberOfBombsSurrounded;

  bool hasBomb() {
    return type == CellType.bomb;
  }

  Cell({this.type}) {
    numberOfBombsSurrounded = 0;
  }

  setType(int numberOfBombsSurround) {
    numberOfBombsSurrounded = numberOfBombsSurround;
    type = _getType(numberOfBombsSurround);
  }

  _getType(int value) {
    switch (value) {
      case 0:
        return CellType.zero;
      case 1:
        return CellType.one;
      case 2:
        return CellType.two;
      case 3:
        return CellType.three;
      case 4:
        return CellType.four;
      case 5:
        return CellType.five;
      case 6:
        return CellType.six;
      case 7:
        return CellType.seven;
      case 8:
        return CellType.eight;
    }
  }
}



enum CellType {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  bomb,
  facingDown,
  flagged
}
