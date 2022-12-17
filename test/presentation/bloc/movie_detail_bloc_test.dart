import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations, GetWatchListStatus])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListStatus,
    );
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    "Should emit [Loading, HasData] when Movie Detail response is successfully",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return movieDetailBloc;
    },
    act: (MovieDetailBloc bloc) => bloc.add(OnMovieDetailHasId(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(
        testMovieDetail,
        testMovieList,
        true,
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "Should emit [Loading, Error] when Get Movie Detail response is unsuccessful",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return movieDetailBloc;
    },
    act: (MovieDetailBloc bloc) => bloc.add(OnMovieDetailHasId(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError(
        'Server Failure',
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    "Should emit [Loading, Error] when Movie Recommendations response is unsuccessful",
    build: () {
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);

      return movieDetailBloc;
    },
    act: (MovieDetailBloc bloc) => bloc.add(OnMovieDetailHasId(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
  );
}
