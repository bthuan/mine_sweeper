import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/cell.dart';
import 'package:mine_sweeper/widgets/cell_widget.dart';

void main() {
  testWidgets('Cell Widget display image correctly',
      (WidgetTester tester) async {
    Cell cell = Cell(type: CellType.bomb);
    await tester.pumpWidget(CellWidget(cell: cell));
    final RenderSemanticsAnnotations renderer =
        tester.renderObject<RenderSemanticsAnnotations>(find.byType(Image));
    expect(renderer.size, const Size(800.0, 600.0));
  });
}
