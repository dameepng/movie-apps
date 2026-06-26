import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVStatus usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTVStatus(mockTVRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
