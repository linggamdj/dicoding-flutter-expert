part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmpty extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailHasData extends TvSeriesDetailState {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> tvSeriesList;
  final bool watchlistStatus;

  TvSeriesDetailHasData(this.tvSeries, this.tvSeriesList, this.watchlistStatus);

  @override
  List<Object> get props => [tvSeries, tvSeriesList, watchlistStatus];
}
