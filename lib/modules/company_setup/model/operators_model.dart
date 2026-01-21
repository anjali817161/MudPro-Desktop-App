class OperatorModel {
  final String company;
  final String contact;
  final String address;
  final String phone;
  final String email;
  final String logoUrl;

  OperatorModel({
    required this.company,
    required this.contact,
    required this.address,
    required this.phone,
    required this.email,
    required this.logoUrl,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    return OperatorModel(
      company: json['company'] ?? '',
      contact: json['contact'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "company": company,
        "contact": contact,
        "address": address,
        "phone": phone,
        "email": email,
        "logoUrl": logoUrl,
      };
}
