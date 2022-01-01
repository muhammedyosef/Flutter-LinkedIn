// ignore: file_names
class Welcome {
  Welcome(
      {this.firstName,
      this.lastName,
      this.country,
      this.city,
      this.jobTitle,
      this.company,
      this.employmentType,
      this.ID,
      this.img,
      this.security});
  String ID;
  String img;
  String security;
  String firstName;
  String lastName;
  String country;
  String city;
  String jobTitle;
  String company;
  String employmentType;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        firstName: json["firstName"] == null ? "" : json["firstName"],
        ID: json["ID"] == null ? "" : json["ID"],
        img: json["img"] == null ? "" : json["img"],
        security: json["security"] == null ? "" : json["security"],
        lastName: json["lastName"] == null ? "" : json["lastName"],
        country: json["country"] == null ? "" : json["country"],
        city: json["city"] == null ? "" : json["city"],
        jobTitle: json["jobTitle"] == null ? "" : json["jobTitle"],
        company: json["company"] == null ? "" : json["company"],
        employmentType:
            json["employmentType"] == null ? "" : json["employmentType"],
      );
}
