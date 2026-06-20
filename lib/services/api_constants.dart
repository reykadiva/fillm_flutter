class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/original';

  // Token bawaan dari modul
  static const String bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Y2M0MzUxOWUyMWRhNGFlNTJmOTc1YTVjMjQzNmMwNCIsIm5iZiI6MTc4MTk2NTk1Ni43OTksInN1YiI6IjZhMzZhNDg0N2Q5YWY0YWM1ODRkM2FkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XhsNdOoNZCNpwTi4YrZGIu_zkdpztwion7SbjojcLX4';

  static Map<String, String> get headers => {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=utf-8',
      };
}
