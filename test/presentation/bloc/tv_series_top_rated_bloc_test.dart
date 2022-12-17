import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    "Should emit [Loading, HasData] when Get Top Rated TV Series response is successfully",
    build: () {
      when(
        mockGetTopRatedTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      return topRatedTvSeriesBloc;
    },
    act: (TopRatedTvSeriesBloc bloc) => bloc.add(OnTopRatedTvSeriesHasData()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(tTvSeriesList),
    ],
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    "Should emit [Loading, Error] when Get Top Rated TV Series response is unsuccessful",
    build: () {
      when(
        mockGetTopRatedTvSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedTvSeriesBloc;
    },
    act: (TopRatedTvSeriesBloc bloc) => bloc.add(OnTopRatedTvSeriesHasData()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
  );
}
