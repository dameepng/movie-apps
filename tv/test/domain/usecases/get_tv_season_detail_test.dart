import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSeasonDetail(mockTVRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tTVSeasonDetail = TVSeasonDetail(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    seasonNumber: 1,
    episodes: [],
  );

  test('should get season detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTVSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(tTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(tTVSeasonDetail));
  });
}
