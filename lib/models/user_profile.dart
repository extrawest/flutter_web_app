import 'dart:convert';

class UserProfile {
  UserProfile({
    this.id,
    this.phone,
    this.lastName,
    this.firstName,
    this.location,
    this.email,
    this.gender,
    this.title,
    this.registerDate,
    this.picture,
    this.dateOfBirth,
  });

  final String? id;
  final String? phone;
  final String? lastName;
  final String? firstName;
  final Location? location;
  final String? email;
  final String? gender;
  final String? title;
  final DateTime? registerDate;
  final String? picture;
  final DateTime? dateOfBirth;

  factory UserProfile.fromRawJson(String str) => UserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'],
        phone: json['phone'],
        lastName: json['lastName'],
        firstName: json['firstName'],
        location: json['location'] == null ? null : Location.fromJson(json['location']),
        email: json['email'],
        gender: json['gender'],
        title: json['title'],
        registerDate: json['registerDate'] == null ? null : DateTime.parse(json['registerDate']),
        picture: json['picture'],
        dateOfBirth: json['dateOfBirth'] == null ? null : DateTime.parse(json['dateOfBirth']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'lastName': lastName,
        'firstName': firstName,
        'location': location == null ? null : location!.toJson(),
        'email': email,
        'gender': gender,
        'title': title,
        'registerDate': registerDate == null ? null : registerDate!.toIso8601String(),
        'picture': picture,
        'dateOfBirth': dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
      };
}

class Location {
  Location({
    this.state,
    this.street,
    this.city,
    this.timezone,
    this.country,
  });

  final String? state;
  final String? street;
  final String? city;
  final String? timezone;
  final String? country;

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        state: json['state'],
        street: json['street'],
        city: json['city'],
        timezone: json['timezone'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() => {
        'state': state,
        'street': street,
        'city': city,
        'timezone': timezone,
        'country': country,
      };
}
