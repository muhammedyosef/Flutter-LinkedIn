// ignore: file_names
class Comment {
  Comment({
    this.Name,
    this.body,
    this.img,
    this.IDD,
  });
  String Name;
  String body;
  String img;
  String IDD;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        Name: json["Name"] == null ? "" : json["Name"],
        body: json["body"] == null ? "" : json["body"],
        img: json["img"] == null ? "" : json["img"],
        IDD: json["IDD"] == null ? "" : json["IDD"],
      );
}
