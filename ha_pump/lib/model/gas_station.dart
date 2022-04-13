class GasStation {
  GasStation({
    required this.imageUrl,
    required this.name,
    required this.latLng,
    required this.address,
    required this.contact,
    required this.range,
  });

  GasStation.fromJSON(Map<String, Object?> json)
      : this(
          imageUrl: (json['imageUrl']! as List).cast<String>(),
          name: json['name']! as String,
          latLng: (json['latLng']! as List).cast<double>(),
          address: json['address']! as String,
          contact: json['contact']! as String,
          range: json['range']! as double,
        );

  final List<String> imageUrl;
  final String name;
  final List<double> latLng;
  final String address;
  final String contact;
  final double range;

  Map<String, Object?> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'latLng': latLng,
      'address': address,
      'contact': contact,
      'range': range,
    };
  }
}
