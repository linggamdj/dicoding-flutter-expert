part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieData;
  final List<Movie> moviesData;
  final bool watchlistStatus;

  MovieDetailHasData(this.movieData, this.moviesData, this.watchlistStatus);

  @override
  List<Object> get props => [movieData, moviesData, watchlistStatus];
}
