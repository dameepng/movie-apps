import 'package:ditonton/common/env.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const baseUrl = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tTVList = const TVResponse(tvList: []).tvList;
  const tQuery = 'spiderman';

  group('get On The Air TVs', () {
    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      // act
      final result = await dataSource.getOnTheAirTVs();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVs', () {
    test('should return list of tvs when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      // act
      final result = await dataSource.getPopularTVs();
      // assert
      expect(result, tTVList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TVs', () {
    test('should return list of tvs when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      // act
      final result = await dataSource.getTopRatedTVs();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV detail', () {
    const tId = 1;

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    const tId = 1;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      // act
      final result = await dataSource.getTVRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvs', () {
    test('should return list of tvs when response to search is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      // act
      final result = await dataSource.searchTVs(tQuery);
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
