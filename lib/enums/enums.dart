enum ImageType {
  asset,
  network,
  file,
  svg,
}

enum ProductCustomizationType {
  image('image'),
  metal('metal'),
  head('head'),
  metalKaratage('metal_karatage'),
  ringSize('ring_size'),
  diamondQuality('diamond_quality'),
  other('other'),
  ;

  final String value;

  const ProductCustomizationType(this.value);
}

enum OrderStatus {
  inProgress('in_progress'),
  active('active'),
  onGoing('on_going'),
  winner('winner'),
  lost('lost'),
  ;

  final String value;

  const OrderStatus(this.value);
}

enum UserType {
  b2cUser,
  b2bUser,
}
