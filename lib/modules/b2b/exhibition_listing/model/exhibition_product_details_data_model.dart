class ExhibitionProductDetailsDataModel {
  ExhibitionProductDetailsDataModel({this.itemsSold, this.totalOrders, this.totalSales, this.avgOrder, this.leads});

  final int? itemsSold;
  final int? totalOrders;
  final String? totalSales;
  final String? avgOrder;
  final int? leads;

  factory ExhibitionProductDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return ExhibitionProductDetailsDataModel(
      itemsSold: json["items_sold"],
      totalOrders: json["total_orders"],
      totalSales: json["total_sales"],
      avgOrder: json["avg_order"],
      leads: json["leads"],
    );
  }

  Map<String, dynamic> toJson() => {
    "items_sold": itemsSold,
    "total_orders": totalOrders,
    "total_sales": totalSales,
    "avg_order": avgOrder,
    "leads": leads,
  };
}
