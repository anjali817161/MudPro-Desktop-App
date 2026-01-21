class Product {
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
  String c;
  String d;
  String e;
  String f;
  bool isDeleted;

  Product({
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
    this.c = '',
    this.d = '',
    this.e = '',
    this.f = '',
    this.isDeleted = false,
  });

  // Convert to JSON for API
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'product': product,
      'code': code,
      'sg': sg,
      'unitNum': unitNum,
      'unitClass': unitClass,
      'group': group,
      'retail': retail,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'e': e,
      'f': f,
      'isDeleted': isDeleted,
    };
  }

  // Create from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      product: json['product'] ?? '',
      code: json['code'] ?? '',
      sg: json['sg'] ?? '',
      unitNum: json['unitNum'] ?? '',
      unitClass: json['unitClass'] ?? '',
      group: json['group'] ?? '',
      retail: json['retail'] ?? '',
      a: json['a'] ?? '',
      b: json['b'] ?? '',
      c: json['c'] ?? '',
      d: json['d'] ?? '',
      e: json['e'] ?? '',
      f: json['f'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
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
        b.isNotEmpty ||
        c.isNotEmpty ||
        d.isNotEmpty ||
        e.isNotEmpty ||
        f.isNotEmpty;
  }

  // Create a copy with updated fields
  Product copyWith({
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
    String? c,
    String? d,
    String? e,
    String? f,
    bool? isDeleted,
  }) {
    return Product(
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
      c: c ?? this.c,
      d: d ?? this.d,
      e: e ?? this.e,
      f: f ?? this.f,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}