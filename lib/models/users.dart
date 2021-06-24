import 'dart:convert';

class PaginatedUsers {
  PaginatedUsers({
    this.users,
    this.total,
    this.page,
    this.limit,
    this.offset,
  });

  final List<User>? users;
  final int? total;
  final int? page;
  final int? limit;
  final int? offset;

  factory PaginatedUsers.fromRawJson(String str) => PaginatedUsers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaginatedUsers.fromJson(Map<String, dynamic> json) => PaginatedUsers(
        users: json['data'] == null ? null : List<User>.from(json['data'].map((x) => User.fromJson(x))),
        total: json['total'],
        page: json['page'],
        limit: json['limit'],
        offset: json['offset'],
      );

  Map<String, dynamic> toJson() => {
        'data': users == null ? null : List<dynamic>.from(users!.map((x) => x.toJson())),
        'total': total,
        'page': page,
        'limit': limit,
        'offset': offset,
      };
}

class User {
  User({
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.title,
    this.picture,
  });

  final String? id;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? title;
  final String? picture;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        lastName: json['lastName'],
        firstName: json['firstName'],
        email: json['email'],
        title: json['title'],
        picture: json['picture'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lastName': lastName,
        'firstName': firstName,
        'email': email,
        'title': title,
        'picture': picture,
      };
}
