import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;
  late TvSeasonDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    notifier = TvSeasonDetailNotifier(getTvSeasonDetail: mockGetTvSeasonDetail)
      ..addListener(() {
        listenerCallCount++;
      });
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(tTvSeasonDetail));
    // act
    notifier.fetchTvSeasonDetail(tId, tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv season data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(tTvSeasonDetail));
    // act
    await notifier.fetchTvSeasonDetail(tId, tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.seasonDetail, tTvSeasonDetail);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSeasonDetail(tId, tSeasonNumber);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
