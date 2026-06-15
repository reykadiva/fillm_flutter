import 'package:flutter_test/flutter_test.dart';

import 'package:halo_flutter/main.dart';

void main() {
  testWidgets('Movie list page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title "Latest Movies" is shown.
    expect(find.text('Latest Movies'), findsOneWidget);

    // Verify that the movie "Obsession" is found.
    expect(find.text('Obsession'), findsOneWidget);
  });
}
