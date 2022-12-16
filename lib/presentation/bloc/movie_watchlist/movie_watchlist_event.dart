part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieWatchlist extends MovieWatchlistEvent {
  OnGetMovieWatchlist();

  @override
  List<Object> get props => [];
}

class OnMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddMovieToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnAddMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieToWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnRemoveMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
