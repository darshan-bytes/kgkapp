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

enum ProjectStatus {
  blueInProgress('blue_in_progress'),
  orangeInProgress('orange_in_progress'),
  active('active'),
  onGoing('on_going'),
  winner('winner'),
  lost('lost'),
  approved('approved'),
  released('released'),
  approval('approval'),
  styleCreated('style_created'),
  onTime('on_time'),
  created('created'),
  inActive('in_active'),
  ;

  final String value;

  const ProjectStatus(this.value);
}

enum UserType {
  b2cUser,
  b2bUser,
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

enum CalenderEventType {
  meeting('meeting'),
  task('task'),
  undefined('undefined'),
  ;

  const CalenderEventType(this.value);

  final String value;
}

/// DIY Progress Bar Chevron Widget Enums
enum Edge { top, right, bottom, left }

enum Clipper { start, center, end }
