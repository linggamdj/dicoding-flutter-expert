part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistState {
  final String message;

  WatchlistHasData(this.message);

  @override
  List<Object> get props => [message];
}
