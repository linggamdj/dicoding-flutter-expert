part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddMovieWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  AddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;

  RemoveMovieFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
