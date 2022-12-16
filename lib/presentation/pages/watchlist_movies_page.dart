import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<MovieWatchlistBloc>().add(OnGetMovieWatchlist());
        context.read<TvSeriesWatchlistBloc>().add(OnGetTvSeriesWatchlist());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(OnGetMovieWatchlist());
    context.read<TvSeriesWatchlistBloc>().add(OnGetTvSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie',
                style: kHeading6,
              ),
              SizedBox(height: 8.0),
              BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                builder: (context, state) {
                  if (state is MovieWatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieWatchlistHasData) {
                    return Column(
                      children: [
                        state.movies.length == 0
                            ? Text(
                                'Empty',
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final movie = state.movies[index];
                                  return MovieCard(movie);
                                },
                                itemCount: state.movies.length,
                              ),
                      ],
                    );
                  } else if (state is MovieWatchlistError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Text("Failed");
                  }
                },
              ),
              SizedBox(height: 8.0),
              Text(
                'TV Series',
                style: kHeading6,
              ),
              SizedBox(height: 8.0),
              BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
                builder: (context, state) {
                  if (state is TvSeriesWatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvSeriesWatchlistHasData) {
                    return Column(
                      children: [
                        state.tvSeriesList.isEmpty
                            ? Text(
                                'Empty',
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final series = state.tvSeriesList[index];
                                  return TvSeriesCard(series);
                                },
                                itemCount: state.tvSeriesList.length,
                              ),
                      ],
                    );
                  } else if (state is TvSeriesWatchlistError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Text("Failed");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
