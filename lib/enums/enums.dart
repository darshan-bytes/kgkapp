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

/// [B2BListingType] -  Representing various listing types of B2B Listing.
enum B2BListingType {
  conceptListingType,
  presentationType,
  presentationListingType,
  projectListingType,
  designBriefsType,
  designListingType,
  stylesListingType,
  monitoringPresentationListingType,
  monitoringPresentationGridType,
  monitoringDbfType,
  monitoringDesignsType,
  monitoringStylesType,
  watchlistType,
  exhibitionDetailPageProductsType,
  exhibitionDetailPageOrdersType,
  retailerOrderListingJewelleryType,
  retailerOrderListingDiamondType,
  userListingType,
  newsletterSubscribersType,
  manufacturerOrderListingType,
}
