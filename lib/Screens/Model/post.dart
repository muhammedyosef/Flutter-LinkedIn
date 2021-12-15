// ignore: file_names
class Post {
  Post({
    this.name,
    this.body,
  });
  String name;
  String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        name: json["name"] == null ? "" : json["name"],
        body: json["body"] == null ? "" : json["body"],
      );
}
