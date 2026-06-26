import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final int episodeNumber;
  final String name;
  final String overview;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  const Episode({
    required this.id,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        id,
        episodeNumber,
        name,
        overview,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
