import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetTvSeriesWatchListStatus _getTvSeriesWatchListStatus;
  final SaveTvSeriesWatchlist _saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist _removeTvSeriesWatchlist;

  TvSeriesWatchlistBloc(
      this._getWatchlistTvSeries,
      this._getTvSeriesWatchListStatus,
      this._saveTvSeriesWatchlist,
      this._removeTvSeriesWatchlist)
      : super(TvSeriesWatchlistEmpty()) {
    on<OnGetTvSeriesWatchlist>(
      (event, emit) async {
        emit(TvSeriesWatchlistLoading());
        final result = await _getWatchlistTvSeries.execute();

        result.fold(
          (failure) {
            emit(TvSeriesWatchlistError(failure.message));
          },
          (tvSeriesList) {
            emit(TvSeriesWatchlistHasData(tvSeriesList));
          },
        );
      },
    );

    on<OnTvSeriesWatchlistStatus>(
      (event, emit) async {
        final result = await _getTvSeriesWatchListStatus.execute(event.id);
        emit(TvSeriesWatchlistStatus(result));
      },
    );

    on<OnAddTvSeriesToWatchlist>(
      (event, emit) async {
        final _tvSeries = event.tvSeriesDetail;
        final result = await _saveTvSeriesWatchlist.execute(_tvSeries);

        result.fold(
          (failure) async {
            emit(TvSeriesWatchlistError(failure.message));
          },
          (success) async {
            emit(TvSeriesWatchlistMessage(success));
          },
        );
      },
    );

    on<OnRemoveTvSeriesToWatchlist>(
      (event, emit) async {
        final _tvSeries = event.tvSeriesDetail;
        final result = await _removeTvSeriesWatchlist.execute(_tvSeries);

        result.fold(
          (failure) async {
            emit(TvSeriesWatchlistError(failure.message));
          },
          (success) async {
            emit(TvSeriesWatchlistMessage(success));
          },
        );
      },
    );
  }
}
