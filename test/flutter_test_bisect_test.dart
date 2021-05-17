import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.onlyPumps;
  }

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

    Offset widgetCenter = tester.getRect(find.byType(GestureDetector)).center;
    print(widgetCenter);

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(invocations, 1);

    await tester.binding.setSurfaceSize(const Size(200, 300));
    await tester.pump();

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(invocations, 2);

    await tester.binding.setSurfaceSize(null);
    await tester.pump();

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(invocations, 3);
  });
}
