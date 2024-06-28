class ProductInfoClarityChat {
  String? productId;
  String? productName;
  String? ct;
  String? shape;
  String? colour;
  String? clarity;
  String? lotNumber;
  String? certificateNumber;
  String? lab;
  String? cut;
  String? polish;
  String? symmetry;
  String? flourish;
  String? tablePercentage;
  String? depthPercentage;
  String? measurements;
  String? rap;
  String? discount;
  String? perCts;
  String? amount;
  String? rapRate;
  String? fluorescence;

  ProductInfoClarityChat({
    this.productId,
    this.productName,
    this.ct,
    this.shape,
    this.colour,
    this.clarity,
    this.lotNumber,
    this.certificateNumber,
    this.measurements,
    this.lab,
    this.cut,
    this.polish,
    this.symmetry,
    this.flourish,
    this.perCts,
    this.rap,
    this.discount,
    this.amount,
    this.depthPercentage,
    this.tablePercentage,
    this.rapRate,
    this.fluorescence,
  });

  factory ProductInfoClarityChat.fromJson(Map<String, dynamic> json) => ProductInfoClarityChat(
        productId: json["product_id"],
        productName: json["product_name"],
        ct: json["ct"],
        shape: json["shape"],
        colour: json["colour"],
        clarity: json["clarity"],
        lotNumber: json["lot_number"],
        certificateNumber: json["certificate_number"],
        measurements: json["measurements"],
        lab: json["lab"],
        cut: json["cut"],
        polish: json["polish"],
        symmetry: json["symmetry"],
        flourish: json["flourish"],
        perCts: json["per_cts"],
        rap: json["rap"],
        discount: json["discount"],
        amount: json["amount"],
        depthPercentage: json["depth_percentage"],
        tablePercentage: json["table_percentage"],
        rapRate: json["rap_rate"],
        fluorescence: json["fluorescence"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "ct": ct,
        "shape": shape,
        "colour": colour,
        "clarity": clarity,
        "lot_number": lotNumber,
        "certificate_number": certificateNumber,
        "measurements": measurements,
        "lab": lab,
        "cut": cut,
        "polish": polish,
        "symmetry": symmetry,
        "flourish": flourish,
        "per_cts": perCts,
        "rap": rap,
        "discount": discount,
        "amount": amount,
        "depth_percentage": depthPercentage,
        "table_percentage": tablePercentage,
        "rap_rate": rapRate,
        "fluorescence": fluorescence,
      };
}
