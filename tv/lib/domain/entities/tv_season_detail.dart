import 'package:tv/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class TVSeasonDetail extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;
  final List<Episode> episodes;

  const TVSeasonDetail({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
