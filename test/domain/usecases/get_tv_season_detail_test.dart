import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonDetail(mockTvRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tTvSeasonDetail = TvSeasonDetail(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    seasonNumber: 1,
    episodes: [],
  );

  test('should get season detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(tTvSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(tTvSeasonDetail));
  });
}
