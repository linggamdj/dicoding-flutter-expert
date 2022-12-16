import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus _getWatchlistTvSeriesStatus;

  TvSeriesDetailBloc(this._getTvSeriesDetail, this._getTvSeriesRecommendations,
      this._getWatchlistTvSeriesStatus)
      : super(TvSeriesDetailEmpty()) {
    on<OnTvSeriesDetailHasId>(
      (event, emit) async {
        final tvSeriesId = event.id;

        emit(TvSeriesDetailLoading());
        final detailResult = await _getTvSeriesDetail.execute(tvSeriesId);
        final watchlistStatus =
            await _getWatchlistTvSeriesStatus.execute(tvSeriesId);
        final recomsResult =
            await _getTvSeriesRecommendations.execute(tvSeriesId);

        detailResult.fold(
          (failure) async {
            emit(TvSeriesDetailError(failure.message));
          },
          (tvSeries) async {
            recomsResult.fold(
              (failure) {
                emit(TvSeriesDetailError(failure.message));
              },
              (tvSeriesList) async {
                emit(TvSeriesDetailHasData(
                    tvSeries, tvSeriesList, watchlistStatus));
              },
            );
          },
        );
      },
    );
  }
}
