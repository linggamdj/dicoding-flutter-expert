import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  final int id;
  final String name;
  final List<GenreModel> genres;
  final String posterPath;
  final double voteAverage;
  final String overview;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<SeasonModel> seasons;

  TvSeriesDetailModel({
    required this.id,
    required this.name,
    required this.genres,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
  });

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        id: json['id'],
        name: json['name'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        overview: json['overview'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: this.id,
      name: this.name,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      overview: this.overview,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        genres,
        posterPath,
        voteAverage,
        overview,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
      ];
}
