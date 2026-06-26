import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTVModel = TVModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTV = TV(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('On The Air TVs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      final resultList = result.fold((l) => l, (r) => r);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTVs();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVs());
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Popular TVs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTVs();
      // assert
      verify(mockRemoteDataSource.getPopularTVs());
      final resultList = result.fold((l) => l, (r) => r);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVs();
      // assert
      verify(mockRemoteDataSource.getPopularTVs());
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('Top Rated TVs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      verify(mockRemoteDataSource.getTopRatedTVs());
      final resultList = result.fold((l) => l, (r) => r);
      expect(resultList, tTVList);
    });
  });

  group('Search TVs', () {
    const tQuery = 'spiderman';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      final resultList = result.fold((l) => l, (r) => r);
      expect(resultList, tTVList);
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });
  });
}
