class MinutelyForecast {
  final int dt;
  final double precipitation;

  MinutelyForecast({
    required this.dt,
    required this.precipitation,
  });

  factory MinutelyForecast.fromJson(Map<String, dynamic> json) {
    return MinutelyForecast(
      dt: json['dt'],
      precipitation: json['precipitation'] == null ? json['precipitation'] : 0,
    );
  }
}
