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
