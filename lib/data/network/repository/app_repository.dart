import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/landing/landing_modules/home/mode/home_strapi_model.dart';
import 'package:kgk/modules/b2b/stone_landing/model/gemstone_strapi_model.dart';
import 'package:kgk/modules/b2b/stone_landing/model/jewelleries_strapi_model.dart';

import '../../../modules/b2b/stone_landing/model/diamonds_strapi_model.dart';

class AppRepository extends ApiService {
  final BuildContext context;

  AppRepository(this.context);

  /// Fetches the home data from the Strapi CMS
  Future<Either<ErrorResponse, List<Home>>> fetchStrapiHomeData() async {
    try {
      final response = await http.get(Uri.parse(ApiClient.strapiHomeApiUrl));

      if (response.statusCode == 200) {
        final homeStrapiModel = HomeStrapiModel.fromJson(jsonDecode(response.body));
        List<Home> homeStrapiList = homeStrapiModel.data.first.attributes?.home ?? [];
        return Right(homeStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  /// Fetches the diamond data from the Strapi CMS
  Future<Either<ErrorResponse, List<DiamondData>>> fetchStrapiDiamondLandingData() async {
    String url = await buildUrl(endpoint: StrapiEndPoints.diamondPage, attribute: Attributes.diamondPage);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final diamondsStrapiModel = DiamondsStrapiModel.fromJson(jsonDecode(response.body));
        List<DiamondData> diamondStrapiList = diamondsStrapiModel.data.first.attributes?.diamonds ?? [];
        return Right(diamondStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  /// Fetches the gemstone data from the Strapi CMS
  Future<Either<ErrorResponse, List<Gemstone>>> fetchStrapiGemstoneLandingData() async {
    String url = await buildUrl(endpoint: StrapiEndPoints.gemstonePage, attribute: Attributes.gemstonePage);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final gemstonesStrapiModel = GemstoneStrapiModel.fromJson(jsonDecode(response.body));
        List<Gemstone> gemstoneStrapiList = gemstonesStrapiModel.data.first.attributes?.gemstones ?? [];
        return Right(gemstoneStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  /// Fetches the jewellery data from the Strapi CMS
  Future<Either<ErrorResponse, List<Jewellery>>> fetchStrapiJewelleryLandingData() async {
    String url = await buildUrl(endpoint: StrapiEndPoints.jewelleryPage, attribute: Attributes.jewelleryPage);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jewelleryStrapiModel = JewelleryStrapiModel.fromJson(jsonDecode(response.body));
        List<Jewellery> jewelleryStrapiList = jewelleryStrapiModel.data.first.attributes?.jewelleries ?? [];
        return Right(jewelleryStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  /// Fetches diamond list
  Future<Either<ErrorResponse, DiamondListingModel>?> fetchDiamondList(
      {required String limit, required String page, bool isLoadMore = false, required String type}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<DiamondListingModel>(ApiClient.diamondListing,
        query: {ApiKey.limit: limit, ApiKey.page: page, ApiKey.type: type}, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  /// Fetches gemstone list
  Future<Either<ErrorResponse, GemstoneListingModel>?> fetchGemstoneList(
      {required String limit, required String page, bool isLoadMore = false, required String type}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<GemstoneListingModel>(ApiClient.gemstoneListing,
        query: {ApiKey.limit: limit, ApiKey.page: page}, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  /// Fetches jewellery list
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchJewelleryList(
      {required String limit, required String page, bool isLoadMore = false, required String type}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryListingModel>(ApiClient.jewelleryListing,
        query: {ApiKey.limit: limit, ApiKey.page: page}, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  Future<Either<ErrorResponse, WishlistModel>?> fetchWishList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response =
        await getMethod<WishlistModel>(ApiClient.wishlist, query: {ApiKey.limit: limit, ApiKey.page: page}, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  //For Getting Diamond Details by ID
  Future<Either<ErrorResponse, DiamondDataModel>?> getDiamondDetailById(String id) async {
    context.setAppLoading(true);
    var response = await getMethod<DiamondDataModel>(
      ApiClient.diamondDetails(id),
      query: {ApiKey.view: true},
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Getting Gemstone Details by ID
  Future<Either<ErrorResponse, GemstoneDatum>?> getGemstoneDetailById(String id) async {
    context.setAppLoading(true);
    var response = await getMethod<GemstoneDatum>(
      ApiClient.gemstoneDetails(id),
      query: {ApiKey.view: true},
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For Getting Diamond You May Like by ID
  Future<Either<ErrorResponse, DiamondListingModel>?> getDiamondYouMayLike(String id,
      {required String limit, required String page, bool isLoadMore = false}) async {
    var response = await getMethod<DiamondListingModel>(
      ApiClient.diamondYouMayLike(id),
      query: {ApiKey.page: page, ApiKey.limit: limit},
      withCurrencyHeader: true,
    );
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Getting Watchlist Data
  Future<Either<ErrorResponse, PaginationData<WatchlistData>>?> getWatchList({
    required String limit,
    required String page,
    bool isLoadMore = false,
    String searchQuery = '',
    bool isFullList = false,
  }) async {
    if (!isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<PaginationData<WatchlistData>>(
      ApiClient.watchList,
      query: isFullList
          ? null
          : {
              ApiKey.page: page,
              ApiKey.limit: limit,
              if (searchQuery.isNotEmpty) ApiKey.search: searchQuery,
            },
    );
    if (!isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Create Watchlist
  Future<Either<ErrorResponse, CommonResponse>?> createWatchlist({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    Either<ErrorResponse, dynamic>? response = await postMethod<Map<String, dynamic>>(ApiClient.watchList, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Edit Watchlist
  Future<Either<ErrorResponse, CommonResponse>?> editWatchlist({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    Either<ErrorResponse, dynamic>? response = await putMethod<Map<String, dynamic>>(ApiClient.watchList, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For Getting Gemstone You May Like by ID
  Future<Either<ErrorResponse, GemstoneListingModel>?> getGemstoneYouMayLike(String id,
      {required String limit, required String page, bool isLoadMore = false}) async {
    var response = await getMethod<GemstoneListingModel>(
      ApiClient.gemstoneYouMayAlsoLike(id),
      query: {ApiKey.page: page, ApiKey.limit: limit},
      withCurrencyHeader: true,
    );
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For Getting Jewellery You May Like by ID
  Future<Either<ErrorResponse, JewelleryListingModel>?> getJewelleryYouMayLike(String id,
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryListingModel>(
      ApiClient.jewelleryYouMayAlsoLike(id),
      query: {ApiKey.page: page, ApiKey.limit: limit},
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Deleting Watchlist by ID
  Future<Either<ErrorResponse, CommonResponse>?> deleteWatchList(String id) async {
    context.setAppLoading(true);
    var response = await deleteMethod<Map<String, dynamic>>(ApiClient.watchListById(id), withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Add Product in Watchlist
  Future<Either<ErrorResponse, CommonResponse>?> watchListAddProduct(String watchlistId, Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await postMethod<Map<String, dynamic>>(ApiClient.watchListAddProduct(watchlistId), body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Update Product in Watchlist
  Future<Either<ErrorResponse, CommonResponse>?> watchListUpdateProduct(
      String watchlistId, String productId, Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response =
        await putMethod<Map<String, dynamic>>(ApiClient.watchListUpdateProduct(watchlistId, productId), body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Getting Watchlist details by ID
  Future<Either<ErrorResponse, WatchlistData>?> getWatchListById(String id, {bool isInBackground = false}) async {
    if (!isInBackground) {
      context.setAppLoading(true);
    }
    var response = await getMethod<WatchlistData>(ApiClient.watchListById(id));
    if (!isInBackground) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Remove Product from Watchlist by ID
  Future<Either<ErrorResponse, CommonResponse>?> watchListRemoveProduct(String watchlistId, String productId) async {
    context.setAppLoading(true);
    var response =
        await deleteMethod<Map<String, dynamic>>(ApiClient.watchListRemoveProduct(watchlistId, productId), withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For create wishlist
  Future<Either<ErrorResponse, CommonResponse<WishlistResponseModel>>?> createWishList({required Map<String, dynamic> body}) async {
    var response = await postMethod<WishlistResponseModel>(ApiClient.createWishList, body, withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For delete wishlist
  Future<Either<ErrorResponse, CommonResponse>?> deleteWishList(String id) async {
    var response = await deleteMethod<Map<String, dynamic>>(ApiClient.deleteWishList(id), withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Add Product review
  Future<Either<ErrorResponse, CommonResponse<ProductReviewModel>>?> addProductReview(Map<String, dynamic> body,
      {required List<String> images}) async {
    context.setAppLoading(true);
    var response = await postMultipartMethod<ProductReviewModel>(ApiClient.productReviews, body,
        withFullResponse: true, files: images.map((e) => ModelMultiPartFile(filePath: e, apiKey: ApiKey.files)).toList());
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Get Product Reviews
  Future<Either<ErrorResponse, PaginationData<ProductReviewModel>>?> productReviewsFilter(String productId,
      {Map<String, dynamic>? query, bool isLoadMore = true}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<PaginationData<ProductReviewModel>>(ApiClient.productReviewsFilter(productId), query: query);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // Add Product into Bag
  Future<Either<ErrorResponse, CommonResponse<MyBagDataModel>>?> addToBag({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<MyBagDataModel>(ApiClient.addToBag, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // Delete Entire Bag
  Future<Either<ErrorResponse, CommonResponse<MyBagDataModel>>?> deleteBag({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await deleteMethod<Map<String, CommonResponse<MyBagDataModel>>>(ApiClient.deleteBag, withFullResponse: true, body: body);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, JewelleryListingModel>?> getRecentlyViewedProductList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryListingModel>(
      ApiClient.jewelleryListing,
      query: {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"},
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Getting Product Details by ID
  Future<Either<ErrorResponse, JewelleryDataModel>?> getProductDetailById(String id, {bool isLoadingShow = true}) async {
    if (isLoadingShow) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryDataModel>(
      ApiClient.productDetails(id),
      query: {ApiKey.view: true},
      withCurrencyHeader: true,
    );
    if (isLoadingShow) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Get Recently Viewed Product List for Diamond
  Future<Either<ErrorResponse, DiamondListingModel>?> getDiamondRecentlyViewedProductList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<DiamondListingModel>(
      ApiClient.diamondListing,
      query: {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"},
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Get Recently Viewed Product List for Gemstone
  Future<Either<ErrorResponse, GemstoneListingModel>?> getGemstoneRecentlyViewedProductList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<GemstoneListingModel>(
      ApiClient.gemstoneListing,
      query: {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"},
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }
}

/// This function builds the populate query for the Strapi CMS
String buildPopulateQuery(Map<String, dynamic> components) {
  List<String> populateFields = [];

  void addPopulateField(Map<String, dynamic> component, [String parentPath = '']) {
    String currentPath = parentPath.isNotEmpty ? '$parentPath.' : '';
    component['attributes'].forEach((key, value) {
      if (value['type'] == 'component' || value['type'] == 'dynamiczone') {
        String componentName = value['component'] ?? key;
        String nestedPath = '$currentPath$key';
        populateFields.add(nestedPath);
        if (components.containsKey(componentName)) {
          addPopulateField(components[componentName], nestedPath);
        }
      } else if (value['type'] == 'media') {
        populateFields.add('$currentPath$key');
      }
    });
  }

  components.forEach((componentName, componentValue) {
    addPopulateField(componentValue);
  });

  return populateFields.join(',');
}

/// This function fetches the populated URL from the Strapi CMS
Future<String> getPopulatedUrl() async {
  try {
    final response = await http.get(
      Uri.parse(StrapiEndPoints.builder),
      headers: {'Authorization': 'Bearer ${AppConst.strapiApiToken}'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> temp = json.decode(response.body);

      final Map<String, dynamic> components = {};
      for (var component in temp['data']) {
        components[component['uid']] = component['schema'];
      }

      final String populateQuery = buildPopulateQuery(components);
      return populateQuery;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    printWrapped('Error populating query: $error');
    rethrow;
  }
}

/// This function builds the URL for the Strapi CMS
Future<String> buildUrl({required String endpoint, required String attribute}) async {
  String acceptLanguage = StorageManager().getLocale() ?? 'en';
  String populateQuery = await getPopulatedUrl();
  return "$endpoint?populate[$attribute][populate]=$populateQuery&locale=$acceptLanguage";
}
