import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie_search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final bool isMovie;
  SearchPage({required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                isMovie
                    ? context.read<SearchMovieBloc>().add(OnQueryChanged(query))
                    : context
                        .read<SearchTvSeriesBloc>()
                        .add(OnTvQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isMovie
                ? BlocBuilder<SearchMovieBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchHasData) {
                        final result = state.result;
                        return result.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final movie = result[index];
                                    return MovieCard(movie);
                                  },
                                  itemCount: result.length,
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'Movie Not Found!',
                                  ),
                                ),
                              );
                      } else if (state is SearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  )
                : BlocBuilder<SearchTvSeriesBloc, TvSeriesSearchState>(
                    builder: (context, state) {
                      if (state is TvSearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvSearchHasData) {
                        final result = state.result;
                        return result.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final series = result[index];
                                    return TvSeriesCard(series);
                                  },
                                  itemCount: result.length,
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'TV Series Not Found!',
                                  ),
                                ),
                              );
                      } else if (state is TvSearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
