// ignore: file_names
class JobsData {
  JobsData(
      {this.ID,
      this.PhoneCompany,
      this.About,
      this.contract,
      this.employees,
      this.joptitle,
      this.jobDesc,
      this.jopaddress,
      this.joptype,
      this.namecompany});

  String ID;
  String PhoneCompany;
  String contract;
  String employees;
  String jobDesc;
  String About;
  String jopaddress;
  String joptype;
  String joptitle;
  String namecompany;

  factory JobsData.fromJson(Map<String, dynamic> json) => JobsData(
        PhoneCompany: json["PhoneCompany"] == null ? "" : json["PhoneCompany"],
        ID: json["ID"] == null ? "" : json["ID"],
        contract: json["contract"] == null ? "" : json["contract"],
        employees: json["employees"] == null ? "" : json["employees"],
        jobDesc: json["jobDesc"] == null ? "" : json["jobDesc"],
        jopaddress: json["jopaddress"] == null ? "" : json["jopaddress"],
        joptitle: json["joptitle"] == null ? "" : json["joptitle"],
        joptype: json["joptype"] == null ? "" : json["joptype"],
        namecompany: json["namecompany"] == null ? "" : json["namecompany"],
        About: json["About"] == null ? "" : json["About"],
      );
}
