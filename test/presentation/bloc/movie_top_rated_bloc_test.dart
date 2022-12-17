import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    "Should emit [Loading, HasData] when Get Top Rated Movie response is successfully",
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));

      return topRatedMovieBloc;
    },
    act: (TopRatedMovieBloc bloc) => bloc.add(OnTopRatedMoviesHasData()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(testMovieList),
    ],
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    "Should emit [Loading, Error] when Get Top Rated Movie response is unsuccessful",
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedMovieBloc;
    },
    act: (TopRatedMovieBloc bloc) => bloc.add(OnTopRatedMoviesHasData()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
  );
}
