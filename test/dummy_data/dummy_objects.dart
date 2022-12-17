import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

// Movie
final tId = 1;

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final tMovieModel = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final tMovieList = <Movie>[tMovieModel];
final tQuery = 'fuiyo';

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV Series
final testTvSeries = TvSeries(
  name: "fdsfas",
  firstAirDate: "123",
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  originCountry: ['213', '33'],
  originalLanguage: "ID",
  originalName: "fdfasda",
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 66732,
  name: "Stranger Things",
  numberOfEpisodes: 34,
  numberOfSeasons: 4,
  overview: "Stranger Things",
  posterPath: "/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
  voteAverage: 8.6,
  seasons: [
    Season(
      airDate: '321321',
      episodeCount: 8,
      id: 77680,
      name: "Season 1",
      posterPath: "/rbnuP7hlynAMLdqcQRCpZW9qDkV.jpg",
      seasonNumber: 1,
    )
  ],
);

final tTvSeriesModel = TvSeries(
  firstAirDate: '321',
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'fdsafds',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  originCountry: ['id'],
  originalLanguage: 'id',
  originalName: 'turkturk,',
  voteAverage: 1,
  voteCount: 1,
);

final tTvSeriesList = <TvSeries>[tTvSeriesModel];

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 123,
  name: "fsdafs",
  posterPath: "fsdafs",
  overview: "fsdafs",
);

final testTvSeriesTable = TvSeriesTable(
  id: 123,
  name: "fsdafs",
  posterPath: "fsdafs",
  overview: "fsdafs",
);

final testTvSeriesMap = {
  'id': 123,
  'overview': 'fsdafs',
  'posterPath': 'fsdafs',
  'name': 'fsdafs',
};
