import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('MovieCard should display movie title and overview',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MovieCard(tMovie),
      ),
    ));

    expect(find.text('title'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });
}
