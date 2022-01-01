// ignore: file_names
class Request {
  Request({
    this.firstname,
    this.lastname,
    this.sendFrom,
    this.sendTo,
    this.status,
    this.img,
    this.ID,
  });
  String img;
  String ID;
  String firstname;
  String lastname;
  String sendFrom;
  String sendTo;
  String status;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        firstname: json["firstname"] == null ? "" : json["firstname"],
        lastname: json["lastname"] == null ? "" : json["lastname"],
        sendFrom: json["sendFrom"] == null ? "" : json["sendFrom"],
        sendTo: json["sendTo"] == null ? "" : json["sendTo"],
        status: json["status"] == null ? "" : json["status"],
        img: json["img"] == null ? "" : json["img"],
        ID: json["ID"] == null ? "" : json["ID"],
      );
}
