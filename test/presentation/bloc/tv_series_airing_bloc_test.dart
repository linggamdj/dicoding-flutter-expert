import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_airing/airing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_airing_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTvSeries])
void main() {
  late AiringTvSeriesBloc airingTvSeriesBloc;
  late MockGetAiringTvSeries mockGetAiringTvSeries;

  setUp(() {
    mockGetAiringTvSeries = MockGetAiringTvSeries();
    airingTvSeriesBloc = AiringTvSeriesBloc(mockGetAiringTvSeries);
  });

  blocTest<AiringTvSeriesBloc, AiringTvSeriesState>(
    "Should emit [Loading, HasData] when Get Airing TV Series response is successfully",
    build: () {
      when(
        mockGetAiringTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      return airingTvSeriesBloc;
    },
    act: (AiringTvSeriesBloc bloc) => bloc.add(OnAiringTvSeriesHasData()),
    expect: () => [
      AiringTvSeriesLoading(),
      AiringTvSeriesHasData(tTvSeriesList),
    ],
  );

  blocTest<AiringTvSeriesBloc, AiringTvSeriesState>(
    "Should emit [Loading, Error] when Get Airing TV Series response is unsuccessful",
    build: () {
      when(
        mockGetAiringTvSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return airingTvSeriesBloc;
    },
    act: (AiringTvSeriesBloc bloc) => bloc.add(OnAiringTvSeriesHasData()),
    expect: () => [
      AiringTvSeriesLoading(),
      AiringTvSeriesError('Server Failure'),
    ],
  );
}
