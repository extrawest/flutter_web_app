import 'dart:convert';

class PaginatedPosts {
  PaginatedPosts({
    this.posts,
    this.total,
    this.page,
    this.limit,
    this.offset,
  });

  final List<Post>? posts;
  final int? total;
  final int? page;
  final int? limit;
  final int? offset;

  factory PaginatedPosts.fromRawJson(String str) => PaginatedPosts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaginatedPosts.fromJson(Map<String, dynamic> json) => PaginatedPosts(
        posts: json['data'] == null ? null : List<Post>.from(json['data'].map((x) => Post.fromJson(x))),
        total: json['total'],
        page: json['page'],
        limit: json['limit'],
        offset: json['offset'],
      );

  Map<String, dynamic> toJson() => {
        'data': posts == null ? null : List<dynamic>.from(posts!.map((x) => x.toJson())),
        'total': total,
        'page': page,
        'limit': limit,
        'offset': offset,
      };
}

class Post {
  Post({
    this.owner,
    this.id,
    this.image,
    this.publishDate,
    this.text,
    this.tags,
    this.link,
    this.likes,
  });

  final Owner? owner;
  final String? id;
  final String? image;
  final DateTime? publishDate;
  final String? text;
  final List<String>? tags;
  final String? link;
  final int? likes;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        owner: json['owner'] == null ? null : Owner.fromJson(json['owner']),
        id: json['id'],
        image: json['image'],
        publishDate: json['publishDate'] == null ? null : DateTime.parse(json['publishDate']),
        text: json['text'],
        tags: json['tags'] == null ? null : List<String>.from(json['tags'].map((x) => x)),
        link: json['link'],
        likes: json['likes'],
      );

  Map<String, dynamic> toJson() => {
        'owner': owner == null ? null : owner!.toJson(),
        'id': id,
        'image': image,
        'publishDate': publishDate == null ? null : publishDate!.toIso8601String(),
        'text': text,
        'tags': tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        'link': link,
        'likes': likes,
      };
}

class Owner {
  Owner({
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

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
