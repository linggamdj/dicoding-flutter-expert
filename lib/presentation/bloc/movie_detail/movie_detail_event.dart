part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnMovieDetailHasId extends MovieDetailEvent {
  final int id;

  OnMovieDetailHasId(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  OnAddMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  OnRemoveMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
