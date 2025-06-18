class Restaurant {
  final String name;
  final double lat;
  final double lng;
  final String? photoReference;
  final num? rating;
  final bool? isOpen;
  final String? address; // New field
  final String? phoneNumber; // New field

  Restaurant({
    required this.name,
    required this.lat,
    required this.lng,
    this.photoReference,
    this.rating,
    this.isOpen,
    this.address,
    this.phoneNumber,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      photoReference: json['photos'] != null && json['photos'].isNotEmpty
          ? json['photos'][0]['photo_reference']
          : null,
      rating: json['rating'],
      isOpen: json['opening_hours'] != null ? json['opening_hours']['open_now'] : null,
      address: json['vicinity'], // Assuming vicinity is the address
      phoneNumber: null, // This will be set later when fetching details
    );
  }
}