part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  TvSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistHasData extends TvSeriesWatchlistState {
  final List<TvSeries> tvSeriesList;

  TvSeriesWatchlistHasData(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class TvSeriesWatchlistMessage extends TvSeriesWatchlistState {
  final String successMessage;

  TvSeriesWatchlistMessage(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}
