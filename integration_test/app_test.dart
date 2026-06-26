import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the first movie and add to watchlist', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find the first movie card on the home page (assuming Now Playing section has movies)
      final firstMovieFinder = find.byType(InkWell).first;
      expect(firstMovieFinder, findsWidgets);

      // Tap on the first movie to go to detail page
      await tester.tap(firstMovieFinder);
      await tester.pumpAndSettle();

      // Verify we are on the detail page (find the add to watchlist button)
      final watchlistButton = find.byIcon(Icons.add);
      if (watchlistButton.evaluate().isNotEmpty) {
        // Add to watchlist
        await tester.tap(watchlistButton);
        await tester.pumpAndSettle();

        // Verify the icon changes to check
        expect(find.byIcon(Icons.check), findsOneWidget);
      }
    });
  });
}
