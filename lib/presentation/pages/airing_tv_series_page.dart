import 'package:ditonton/presentation/bloc/tv_series_airing/airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-series';

  @override
  _AiringSeriesPageState createState() => _AiringSeriesPageState();
}

class _AiringSeriesPageState extends State<AiringTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AiringTvSeriesBloc>().add(OnAiringTvSeriesHasData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTvSeriesBloc, AiringTvSeriesState>(
          builder: (context, state) {
            if (state is AiringTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.tvSeriesList[index];
                  return TvSeriesCard(series);
                },
                itemCount: state.tvSeriesList.length,
              );
            } else if (state is AiringTvSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text('Server Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
