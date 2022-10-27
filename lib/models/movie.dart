class Movie {
  int? id;
  String? title;
  double? voteAverage;
  String? releaseDate;
  String? overview;
  String? posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview,
      this.posterPath);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    voteAverage = json['vote_average'] * 1.0;
    releaseDate = json['release_date'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id!,
      'title': title!,
      'poster': posterPath!
    };
  }
}
