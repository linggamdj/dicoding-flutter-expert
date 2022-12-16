import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;

  MovieDetailBloc(this._getMovieDetail, this._getMovieRecommendations,
      this._getWatchListStatus)
      : super(MovieDetailEmpty()) {
    on<OnMovieDetailHasId>(
      (event, emit) async {
        final movieId = event.id;

        emit(MovieDetailLoading());
        final detailResult = await _getMovieDetail.execute(movieId);
        final watchlistStatus = await _getWatchListStatus.execute(movieId);
        final recomsResult = await _getMovieRecommendations.execute(movieId);

        detailResult.fold(
          (failure) async {
            emit(MovieDetailError(failure.message));
          },
          (movieData) async {
            recomsResult.fold(
              (failure) {
                emit(MovieDetailError(failure.message));
              },
              (moviesData) async {
                emit(
                    MovieDetailHasData(movieData, moviesData, watchlistStatus));
              },
            );
          },
        );
      },
    );
  }
}
