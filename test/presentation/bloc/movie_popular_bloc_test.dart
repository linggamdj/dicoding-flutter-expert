import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    "Should emit [Loading, HasData] when Get Popular Movie response is successfully",
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (PopularMovieBloc bloc) => bloc.add(OnPopularMoviesHasData()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(testMovieList),
    ],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    "Should emit [Loading, Error] when Get Popular Movie response is unsuccessful",
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularMovieBloc;
    },
    act: (PopularMovieBloc bloc) => bloc.add(OnPopularMoviesHasData()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
  );
}
