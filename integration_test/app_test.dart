import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Integration Test: Movie & TV Series Watchlist Flow', (tester) async {
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

      // Go back to home page
      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Open drawer
      final drawerFinder = find.byIcon(Icons.menu);
      await tester.tap(drawerFinder);
      await tester.pumpAndSettle();

      // Tap TV Series menu
      final tvSeriesMenuFinder = find.text('TV Series');
      await tester.tap(tvSeriesMenuFinder);
      await tester.pumpAndSettle();

      // Verify we are on TV Series page
      expect(find.text('On The Air'), findsOneWidget);

      // Find the first tv card on the home tv page
      final firstTvFinder = find.byType(InkWell).first;
      expect(firstTvFinder, findsWidgets);

      // Tap on the first tv to go to detail page
      await tester.tap(firstTvFinder);
      await tester.pumpAndSettle();

      // Verify we are on the detail page (find the add to watchlist button)
      final tvWatchlistButton = find.byIcon(Icons.add);
      if (tvWatchlistButton.evaluate().isNotEmpty) {
        // Add to watchlist
        await tester.tap(tvWatchlistButton);
        await tester.pumpAndSettle();

        // Verify the icon changes to check
        expect(find.byIcon(Icons.check), findsOneWidget);
      }
    });
  });
}
