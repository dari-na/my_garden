class Plant {
  final String name; // Required
  final String? variety; // Optional
  final String? source; // Optional
  final DateTime? plantedDate; // Optional

  Plant({
    required this.name,
    this.variety,
    this.source,
    this.plantedDate,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'variety': variety,
    'source': source,
    'plantedDate': plantedDate?.millisecondsSinceEpoch,
  };

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    name: json['name'],
    variety: json['variety'],
    source: json['source'],
      plantedDate: json['plantedDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['plantedDate']) : null,
  );
}
