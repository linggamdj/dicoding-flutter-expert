import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks(
    [GetTvSeriesDetail, GetTvSeriesRecommendations, GetTvSeriesWatchListStatus])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetTvSeriesWatchListStatus mockGetTvSeriesWatchListStatus;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetTvSeriesWatchListStatus = MockGetTvSeriesWatchListStatus();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      mockGetTvSeriesDetail,
      mockGetTvSeriesRecommendations,
      mockGetTvSeriesWatchListStatus,
    );
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "Should emit [Loading, HasData] when TV Series Detail response is successfully",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTvSeriesList));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(OnTvSeriesDetailHasId(tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailHasData(
        testTvSeriesDetail,
        tTvSeriesList,
        true,
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "Should emit [Loading, Error] when TV Series Detail response is unsuccessful",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTvSeriesList));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(OnTvSeriesDetailHasId(tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    "Should emit [Loading, Error] when TV Series Recommendations response is unsuccessful",
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetTvSeriesWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return tvSeriesDetailBloc;
    },
    act: (TvSeriesDetailBloc bloc) => bloc.add(OnTvSeriesDetailHasId(tId)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],
  );
}
