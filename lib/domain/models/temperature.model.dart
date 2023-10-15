class Temperature {
  final double day;
  final double? min;
  final double? max;
  final double night;
  final double eve;
  final double morn;

  Temperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      day: json['day'].toDouble(),
      min: double.tryParse(json['min'].toString()),
      max: double.tryParse(json['max'].toString()),
      night: json['night'].toDouble(),
      eve: json['eve'].toDouble(),
      morn: json['morn'].toDouble(),
    );
  }
}
