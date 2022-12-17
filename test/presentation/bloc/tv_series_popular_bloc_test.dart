import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    "Should emit [Loading, HasData] when Get Popular TV Series response is successfully",
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      return popularTvSeriesBloc;
    },
    act: (PopularTvSeriesBloc bloc) => bloc.add(OnPopularTvSeriesHasData()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    "Should emit [Loading, Error] when Get Popular TV Series response is unsuccessful",
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularTvSeriesBloc;
    },
    act: (PopularTvSeriesBloc bloc) => bloc.add(OnPopularTvSeriesHasData()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
  );
}
