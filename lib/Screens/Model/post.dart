// ignore: file_names
class Post {
  Post({
    this.Name,
    this.body,
    this.idi,
    this.title,
    this.img,
  });
  String Name;
  String body;
  String idi;
  String title;
  String img;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        Name: json["Name"] == null ? "" : json["Name"],
        body: json["body"] == null ? "" : json["body"],
        idi: json["idi"] == null ? "" : json["idi"],
        title: json["title"] == null ? "" : json["title"],
        img: json["img"] == null ? "" : json["img"],
      );
}
