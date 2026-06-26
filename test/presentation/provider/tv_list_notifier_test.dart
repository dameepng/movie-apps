import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetOnTheAirTVs extends Mock implements GetOnTheAirTVs {
  @override
  Future<Either<Failure, List<TV>>> execute() async {
    return super.noSuchMethod(
      Invocation.method(#execute, []),
      returnValue: Future.value(const Right<Failure, List<TV>>(<TV>[])),
    );
  }
}

class MockGetPopularTVs extends Mock implements GetPopularTVs {
  @override
  Future<Either<Failure, List<TV>>> execute() async {
    return super.noSuchMethod(
      Invocation.method(#execute, []),
      returnValue: Future.value(const Right<Failure, List<TV>>(<TV>[])),
    );
  }
}

class MockGetTopRatedTVs extends Mock implements GetTopRatedTVs {
  @override
  Future<Either<Failure, List<TV>>> execute() async {
    return super.noSuchMethod(
      Invocation.method(#execute, []),
      returnValue: Future.value(const Right<Failure, List<TV>>(<TV>[])),
    );
  }
}

void main() {
  late TVListNotifier provider;
  late MockGetOnTheAirTVs mockGetOnTheAirTVs;
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTVs = MockGetOnTheAirTVs();
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    provider = TVListNotifier(
      getOnTheAirTVs: mockGetOnTheAirTVs,
      getPopularTVs: mockGetPopularTVs,
      getTopRatedTVs: mockGetTopRatedTVs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  final tTVList = <TV>[tTV];

  group('on the air tvs', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      verify(mockGetOnTheAirTVs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loaded);
      expect(provider.popularTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loaded);
      expect(provider.topRatedTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
