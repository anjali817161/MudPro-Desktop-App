class ProductModel {
  String? id;
  String product;
  String code;
  String sg;
  String unitNum;
  String unitClass;
  String group;
  String retail;
  String a;
  String b;
  String price;
  String initial;
  bool volAdd;
  bool calculate;
  bool plot;
  bool tax;
  bool isSelected;
  bool isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    this.product = '',
    this.code = '',
    this.sg = '',
    this.unitNum = '',
    this.unitClass = '',
    this.group = '',
    this.retail = '',
    this.a = '',
    this.b = '',
    this.price = '',
    this.initial = '',
    this.volAdd = false,
    this.calculate = false,
    this.plot = false,
    this.tax = false,
    this.isSelected = false,
    this.isDeleted = false,
    this.createdAt,
    this.updatedAt,
  });

  // Convert to JSON for API (single product)
  Map<String, dynamic> toJson() {
    return {
      'Product': product,
      'Code': code,
      'SG': sg.isNotEmpty ? double.tryParse(sg) ?? 0 : 0,
      'Unit': {
        'Num': unitNum.isNotEmpty ? int.tryParse(unitNum) ?? 0 : 0,
        'Class': unitClass,
      },
      'Group': group,
      'Retail': retail.isEmpty ? '' : retail,
      'A': a.isNotEmpty ? int.tryParse(a) ?? 0 : null,
      'B': b.isNotEmpty ? int.tryParse(b) ?? 0 : null,
    };
  }

  // Convert from API response
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      product: json['Product'] ?? '',
      code: json['Code'] ?? '',
      sg: json['SG']?.toString() ?? '',
      unitNum: json['Unit']?['Num']?.toString() ?? '',
      unitClass: json['Unit']?['Class'] ?? '',
      group: json['Group'] ?? '',
      retail: json['Retail'] ?? '',
      a: json['A']?.toString() ?? '',
      b: json['B']?.toString() ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  // Check if product has any data
  bool hasData() {
    return product.isNotEmpty ||
           code.isNotEmpty ||
           sg.isNotEmpty ||
           unitNum.isNotEmpty ||
           unitClass.isNotEmpty ||
           group.isNotEmpty ||
           retail.isNotEmpty ||
           a.isNotEmpty ||
           b.isNotEmpty;
  }

  // Check if product is valid (all required fields filled)
  bool isValid() {
    return product.isNotEmpty &&
           code.isNotEmpty &&
           sg.isNotEmpty &&
           unitNum.isNotEmpty &&
           unitClass.isNotEmpty &&
           group.isNotEmpty;
  }

  // Create a copy
  ProductModel copyWith({
    String? id,
    String? product,
    String? code,
    String? sg,
    String? unitNum,
    String? unitClass,
    String? group,
    String? retail,
    String? a,
    String? b,
  }) {
    return ProductModel(
      id: id ?? this.id,
      product: product ?? this.product,
      code: code ?? this.code,
      sg: sg ?? this.sg,
      unitNum: unitNum ?? this.unitNum,
      unitClass: unitClass ?? this.unitClass,
      group: group ?? this.group,
      retail: retail ?? this.retail,
      a: a ?? this.a,
      b: b ?? this.b,
    );
  }

  // Clear all fields
  void clear() {
    product = '';
    code = '';
    sg = '';
    unitNum = '';
    unitClass = '';
    group = '';
    retail = '';
    a = '';
    b = '';
  }
}