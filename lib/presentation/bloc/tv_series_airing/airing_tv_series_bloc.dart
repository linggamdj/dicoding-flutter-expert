import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'airing_tv_series_event.dart';
part 'airing_tv_series_state.dart';

class AiringTvSeriesBloc
    extends Bloc<AiringTvSeriesEvent, AiringTvSeriesState> {
  final GetAiringTvSeries _getAiringTvSeries;

  AiringTvSeriesBloc(this._getAiringTvSeries) : super(AiringTvSeriesEmpty()) {
    on<OnAiringTvSeriesHasData>((event, emit) async {
      emit(AiringTvSeriesLoading());
      final result = await _getAiringTvSeries.execute();

      result.fold(
        (failure) {
          emit(AiringTvSeriesError(failure.message));
        },
        (series) {
          emit(AiringTvSeriesHasData(series));
        },
      );
    });
  }
}
