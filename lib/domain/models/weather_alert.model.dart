class Alert {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;
  final List<String> tags;

  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      senderName: json['sender_name'],
      event: json['event'],
      start: json['start'],
      end: json['end'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
    );
  }
}
