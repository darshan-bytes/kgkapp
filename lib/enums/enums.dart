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
  onHold('on_hold'),
  wip('wip'),
  pending('pending'),
  completed('completed'),
  cancelled('cancelled'),
  delay('delay');

  final String value;

  const ProjectStatus(this.value);
}

enum UserType {
  b2cUser('individual'),
  b2bUser('company'),
  internal('internal'),
  ;

  const UserType(this.value);

  final String value;
}

enum AccountType {
  customer('customer'),
  ;

  const AccountType(this.value);

  final String value;
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
  myInquiryType,
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
enum Edge { top, end, bottom, start }

enum Clipper { start, center, end }

enum Commodity {
  diamond('diamond'),
  gemstone('gemstone'),
  jewellery('jewellery'),
  styleLibrary('style_library'),
  skuLibrary('sku_library'),
  cadLibrary('cad_library'),
  designLibrary('design_library'),
  finishedGoodLibrary('finished_good_library'),
  diy('diy'),
  ;

  const Commodity(this.value);

  final String value;
}

enum FilterType {
  undefined('undefined'),
  checkbox('checkbox'),
  range('range'),
  dateRange('date_range'),
  date('date'),
  createdBySearch('created_by_search'),
  boolean('boolean'),
  ;

  const FilterType(this.value);

  final String value;
}

enum ModuleKey {
  activityLogs('activity_logs'),
  exhibitions('exhibitions'),
  assetMgmt('asset_mgmt'),
  reviewFeedbacks('review_feedbacks'),
  digitalCatalogue('digital_catalogue'),
  calendars('calendars'),
  messages('messages'),
  cmsPageBuilder('cms_page_builder'),
  companies('companies'),
  currency('currency'),
  leads('leads'),
  request('request'),
  department('department'),
  systemTemplates('system_templates'),
  diamondCategories('diamond_categories'),
  jewelleryCategories('jewellery_categories'),
  gemstoneCategories('gemstone_categories'),
  paymentTerms('payment_terms'),
  filterOptions('filter_options'),
  diamondShapes('diamond_shapes'),
  diamondColors('diamond_colors'),
  jewelleryMetalColors('jewellery_metal_colors'),
  faqs('faqs'),
  tasks('tasks'),
  meetings('meetings'),
  inquiries('inquiries'),
  language('language'),
  auctions('auctions'),
  orders('orders'),
  newsletterSubscribers('newsletter_subscribers'),
  internalNoteTypes('internal_note_types'),
  projects('projects'),
  designs('designs'),
  styles('styles'),
  concepts('concepts'),
  presentations('presentations'),
  retailerStores('retailer_stores'),
  roles('roles'),
  deals('deals'),
  customerGroups('customer_groups'),
  users('users'),
  orion('orion'),
  cadLibrary('cad_library'),
  designLibrary('design_library'),
  finishedGoodLibrary('finished_good_library'),
  skuLibrary('sku_library'),
  styleLibrary('style_library'),
  watchlist('watchlist'),
  wishlist('wishlist'),
  gemstoneShapes('gemstone_shapes');

  const ModuleKey(this.value);

  final String value;
}

enum Priority {
  low('low', 1),
  medium('medium', 2),
  high('high', 3),
  undefined('undefined', 0);

  const Priority(this.stringValue, this.intValue);

  final String stringValue;
  final int intValue;
}

enum BranchLinkTypeType {
  productShare('product_share'),
  ;

  const BranchLinkTypeType(this.value);

  final String value;
}

enum FieldTypeValidationEnum {
  firstName,
  lastName,
  email,
  contactNumber,
  password,
  confirmPassword,
  companyName,
  businessType,
  officeLocation,
  address,
  city,
  state,
  zipcode,
  apartment,
  country,
  currentPassword,
  bidAmount,
}
