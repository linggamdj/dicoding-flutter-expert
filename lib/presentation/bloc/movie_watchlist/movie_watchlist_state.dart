part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> movies;

  MovieWatchlistHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String successMessage;

  MovieWatchlistMessage(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}
