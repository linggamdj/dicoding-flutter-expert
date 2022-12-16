import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieWatchlistBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MovieWatchlistEmpty()) {
    on<OnGetMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistLoading());
        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(MovieWatchlistError(failure.message));
          },
          (movies) {
            emit(MovieWatchlistHasData(movies));
          },
        );
      },
    );

    on<OnMovieWatchlistStatus>(
      (event, emit) async {
        final result = await _getWatchListStatus.execute(event.id);
        emit(MovieWatchlistStatus(result));
      },
    );

    on<OnAddMovieToWatchlist>(
      (event, emit) async {
        final _movie = event.movieDetail;
        final result = await _saveWatchlist.execute(_movie);

        result.fold(
          (failure) async {
            emit(MovieWatchlistError(failure.message));
          },
          (success) async {
            emit(MovieWatchlistMessage(success));
          },
        );
      },
    );

    on<OnRemoveMovieToWatchlist>(
      (event, emit) async {
        final _movie = event.movieDetail;
        final result = await _removeWatchlist.execute(_movie);

        result.fold(
          (failure) async {
            emit(MovieWatchlistError(failure.message));
          },
          (success) async {
            emit(MovieWatchlistMessage(success));
          },
        );
      },
    );
  }
}
