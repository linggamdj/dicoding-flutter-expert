part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvSeriesWatchlist extends TvSeriesWatchlistEvent {
  OnGetTvSeriesWatchlist();

  @override
  List<Object> get props => [];
}

class OnTvSeriesWatchlistStatus extends TvSeriesWatchlistEvent {
  final int id;

  OnTvSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddTvSeriesToWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnAddTvSeriesToWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class OnRemoveTvSeriesToWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  OnRemoveTvSeriesToWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
