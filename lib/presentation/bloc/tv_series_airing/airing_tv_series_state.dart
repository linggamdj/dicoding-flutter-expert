part of 'airing_tv_series_bloc.dart';

abstract class AiringTvSeriesState extends Equatable {
  const AiringTvSeriesState();

  @override
  List<Object> get props => [];
}

class AiringTvSeriesEmpty extends AiringTvSeriesState {}

class AiringTvSeriesLoading extends AiringTvSeriesState {}

class AiringTvSeriesError extends AiringTvSeriesState {
  final String message;

  AiringTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTvSeriesHasData extends AiringTvSeriesState {
  final List<TvSeries> tvSeriesList;

  AiringTvSeriesHasData(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}
