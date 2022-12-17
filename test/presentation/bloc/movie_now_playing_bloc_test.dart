import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    "Should emit [Loading, HasData] when Get Now Playing Movie response is successfully",
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));

      return nowPlayingMovieBloc;
    },
    act: (NowPlayingMovieBloc bloc) => bloc.add(OnNowPlayingMoviesHasData()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieHasData(testMovieList),
    ],
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    "Should emit [Loading, Error] when Get Now Playing Movie response is unsuccessful",
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return nowPlayingMovieBloc;
    },
    act: (NowPlayingMovieBloc bloc) => bloc.add(OnNowPlayingMoviesHasData()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieError('Server Failure'),
    ],
  );
}
