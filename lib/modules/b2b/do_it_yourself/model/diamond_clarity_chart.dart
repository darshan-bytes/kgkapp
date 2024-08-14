class DiamondClarityChart {
  String? ct;
  String? shape;
  String? colour;
  String? clarity;
  String? lotNumber;
  String? certificateNumber;
  String? measurements;
  String? lab;
  String? cut;
  String? polish;
  String? symmetry;
  String? flourish;
  String? table;
  String? depth;
  String? rap;
  String? discount;
  String? kgkAmount;
  String? your;
  String? yourRate;
  String? yourValue;

  DiamondClarityChart({
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
    this.table,
    this.depth,
    this.rap,
    this.discount,
    this.kgkAmount,
    this.your,
    this.yourRate,
      this.yourValue});

  factory DiamondClarityChart.fromJson(Map<String, dynamic> json) => DiamondClarityChart(
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
        table: json["table"],
        depth: json["depth"],
        rap: json["rap"],
        discount: json["discount"],
        kgkAmount: json["kgk_amount"],
        your: json["your"],
        yourRate: json["your_rate"],
      yourValue: json["your_value"]);

  Map<String, dynamic> toJson() => {
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
        "table": table,
        "depth": depth,
        "rap": rap,
        "discount": discount,
        "kgk_amount": kgkAmount,
        "your": your,
        "your_rate": yourRate,
        "your_value": yourValue
      };
}
