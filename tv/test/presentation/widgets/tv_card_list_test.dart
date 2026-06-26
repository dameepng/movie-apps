import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('TVCard should display tv name and overview', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TVCard(tTV),
      ),
    ));

    expect(find.text('name'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });
}
