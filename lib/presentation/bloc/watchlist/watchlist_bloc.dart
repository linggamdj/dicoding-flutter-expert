import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistBloc(this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistEmpty()) {
    on<AddMovieWatchlist>(
      (event, emit) async {
        emit(WatchlistLoading());
        final result = await _saveWatchlist.execute(event.movieDetail);

        result.fold(
          (failure) async {
            emit(WatchlistError(failure.message));
          },
          (movieData) async {
            emit(WatchlistHasData(watchlistAddSuccessMessage));
          },
        );
      },
    );

    on<RemoveMovieFromWatchlist>(
      (event, emit) async {
        emit(WatchlistLoading());
        final result = await _removeWatchlist.execute(event.movieDetail);

        result.fold(
          (failure) async {
            emit(WatchlistError(failure.message));
          },
          (movieData) async {
            emit(WatchlistHasData(watchlistRemoveSuccessMessage));
          },
        );
      },
    );
  }
}
