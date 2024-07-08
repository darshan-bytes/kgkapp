class ManufacturerOrderDetailsModel {
  final String? id;
  final String? orderId;
  final String? orderProductImage;
  final String? orderProductShape;
  final String? orderProductCertificateNumber;
  final String? orderProductMeasurements;
  final String? orderProductLab;
  final String? orderProductCt;
  final String? orderProductColour;
  final String? orderProductClarity;
  final String? orderProductCut;
  final String? orderProductRap;
  final String? orderProductDiscount;
  final String? orderProductKgkAmount;
  final String? orderProductYourPercentage;
  final String? orderProductYourRate;
  final String? orderProductYourValue;

  ManufacturerOrderDetailsModel({
    this.id,
    this.orderId,
    this.orderProductImage,
    this.orderProductShape,
    this.orderProductCertificateNumber,
    this.orderProductMeasurements,
    this.orderProductLab,
    this.orderProductCt,
    this.orderProductColour,
    this.orderProductClarity,
    this.orderProductCut,
    this.orderProductRap,
    this.orderProductDiscount,
    this.orderProductKgkAmount,
    this.orderProductYourPercentage,
    this.orderProductYourRate,
    this.orderProductYourValue,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ManufacturerOrderDetailsModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
