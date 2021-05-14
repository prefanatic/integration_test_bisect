import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final WidgetsBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  assert(binding is IntegrationTestWidgetsFlutterBinding);
  final IntegrationTestWidgetsFlutterBinding integrationBinding =
      binding as IntegrationTestWidgetsFlutterBinding;

  testWidgets('setSurfaceSize works', (WidgetTester tester) async {
    int invocations = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: GestureDetector(
            onTap: () {
              invocations++;
            },
            child: const Text('Test'),
          ),
        ),
      ),
    );

    final Size windowCenter = tester.binding.window.physicalSize /
        tester.binding.window.devicePixelRatio /
        2;
    final double windowCenterX = windowCenter.width;
    final double windowCenterY = windowCenter.height;

    Offset widgetCenter = tester.getRect(find.byType(Text)).center;
    expect(widgetCenter.dx, windowCenterX);
    expect(widgetCenter.dy, windowCenterY);

    await tester.tap(find.byType(Text));
    await tester.pump();
    expect(invocations, 1);

    await tester.binding.setSurfaceSize(const Size(200, 300));
    await tester.pump();
    widgetCenter = tester.getRect(find.byType(Text)).center;
    expect(widgetCenter.dx, 100);
    expect(widgetCenter.dy, 150);

    await tester.tap(find.byType(Text));
    await tester.pump();
    expect(invocations, 2);

    await tester.binding.setSurfaceSize(null);
    await tester.pump();
    widgetCenter = tester.getRect(find.byType(Text)).center;
    expect(widgetCenter.dx, windowCenterX);
    expect(widgetCenter.dy, windowCenterY);

    await tester.tap(find.byType(Text));
    await tester.pump();
    expect(invocations, 3);
  });
}
