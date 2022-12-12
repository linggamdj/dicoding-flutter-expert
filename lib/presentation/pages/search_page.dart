import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
                    ? context.read<SearchBloc>().add(OnQueryChanged(query))
                    : Provider.of<TvSeriesSearchNotifier>(context,
                            listen: false)
                        .fetchTvSeriesSearch(query);
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
                ? BlocBuilder<SearchBloc, SearchState>(
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
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : Consumer<TvSeriesSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;
                        return result.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final series = data.searchResult[index];
                                    return TvSeriesCard(series);
                                  },
                                  itemCount: result.length,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'TV Series Not Found!',
                                  textAlign: TextAlign.center,
                                ),
                              );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
