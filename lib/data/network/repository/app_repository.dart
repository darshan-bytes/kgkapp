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
      final url = await buildUrl(endpoint: StrapiEndPoints.mobileHomePage, attribute: Attributes.homePage);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final homeStrapiModel = HomeStrapiModel.fromJson(jsonDecode(response.body));
        List<Home> homeStrapiList = homeStrapiModel.data.firstOrNull?.attributes?.home ?? [];
        return Right(homeStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? APPStrings.unknownError.tr,
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: APPStrings.errorOccurred.tr,
      ));
    }
  }

  /// Fetches the diamond data from the Strapi CMS
  Future<Either<ErrorResponse, List<FaqData>>> fetchStrapiFaqData() async {
    String url = await buildUrl(endpoint: StrapiEndPoints.faqPage, attribute: Attributes.faqPage);
    try {
      final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer ${AppConst.strapiApiToken}'});
      if (response.statusCode == 200) {
        final faqStrapiModel = FaqStrapiModel.fromJson(jsonDecode(response.body));
        List<FaqData> faqStrapiList = faqStrapiModel.data.first.attributes?.faqs ?? [];
        return Right(faqStrapiList);
      } else {
        return Left(
          ErrorResponse(
            code: response.statusCode,
            message: response.reasonPhrase ?? APPStrings.unknownError.tr,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorResponse(
          code: 500,
          message: APPStrings.errorOccurred.tr,
        ),
      );
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
        return Left(
          ErrorResponse(
            code: response.statusCode,
            message: response.reasonPhrase ?? APPStrings.unknownError.tr,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorResponse(
          code: 500,
          message: APPStrings.errorOccurred.tr,
        ),
      );
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
          message: response.reasonPhrase ?? APPStrings.unknownError.tr,
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: APPStrings.errorOccurred.tr,
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
        message: APPStrings.errorOccurred.tr,
      ));
    }
  }

  Future<void> fetchStrapiDataFroAboutUs(String? attribute) async {
    String url = await buildUrl(endpoint: StrapiEndPoints.aboutUsPage, attribute: attribute ?? '');

    /// TODO :: Implement this letter
  }

  /// Fetches diamond list
  Future<Either<ErrorResponse, DiamondListingModel>?> fetchDiamondList(
      {required String limit,
      required String page,
      String? sortKey,
      String? sortValue,
      bool isLoadMore = false,
      Map<String, String>? query,
      String? type}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    Map<String, String> queryParams = {
      ApiKey.page: page,
      ApiKey.limit: limit,
      if (sortKey != null) ApiKey.sortKey: sortKey,
      if (sortValue != null) ApiKey.sortValue: sortValue,
      if (type != null) ApiKey.type: type
    };
    if (query != null) {
      queryParams.addAll(query);
    }

    var response = await getMethod<DiamondListingModel>(ApiClient.diamondListing, query: queryParams, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  /// Fetches gemstone list
  Future<Either<ErrorResponse, GemstoneListingModel>?> fetchGemstoneList({
    required String limit,
    required String page,
    String? sortKey,
    String? sortValue,
    bool isLoadMore = false,
    String? type,
    Map<String, String>? query,
  }) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    Map<String, String> queryParams = {
      ApiKey.limit: limit,
      ApiKey.page: page,
      if (sortKey != null) ApiKey.sortKey: sortKey,
      if (sortValue != null) ApiKey.sortValue: sortValue,
      if (type != null) ApiKey.subTypeCode: type
    };
    if (query != null) {
      queryParams.addAll(query);
    }
    var response = await getMethod<GemstoneListingModel>(ApiClient.gemstoneListing, query: queryParams, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  /// Fetches jewellery list
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchJewelleryList(
      {required String limit,
      required String page,
      String? sortKey,
      String? sortValue,
      bool isLoadMore = false,
      String? type,
      Map<String, String>? query}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }

    Map<String, String> queryParams = {
      ApiKey.limit: limit,
      ApiKey.page: page,
      if (sortKey != null) ApiKey.sortKey: sortKey,
      if (sortValue != null) ApiKey.sortValue: sortValue,
    };
    if (query != null) {
      queryParams.addAll(query);
    }

    var response = await getMethod<JewelleryListingModel>(ApiClient.jewelleryListing, query: queryParams, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  Future<Either<ErrorResponse, WishlistModel>?> fetchWishList(
      {required String limit, required String page, bool isLoadMore = false, Map<String, String>? query}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    Map<String, String> queryParams = {ApiKey.limit: limit, ApiKey.page: page};
    if (query != null) {
      queryParams.addAll(query);
    }
    var response = await getMethod<WishlistModel>(ApiClient.wishlist, query: queryParams, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  /// getAuctionList
  Future<Either<ErrorResponse, AuctionListingModel>?> getAuctionList({required Map<String, dynamic> body, bool isLoadMore = false}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response = await getMethod<AuctionListingModel>(ApiClient.auctionListing, query: body, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // createBidForAuction
  Future<Either<ErrorResponse, CommonResponse>?> createBidForAuction(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await postMethod<CommonResponse>(ApiClient.createBid, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Getting Diamond Details by ID
  Future<Either<ErrorResponse, DiamondDataModel>?> getDiamondDetailById(String id) async {
    context.setAppLoading(true);
    final Map<String, dynamic> query = {ApiKey.view: true};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    var response = await getMethod<DiamondDataModel>(
      ApiClient.diamondDetails(id),
      query: query,
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Getting Gemstone Details by ID
  Future<Either<ErrorResponse, GemstoneDatum>?> getGemstoneDetailById(String id) async {
    context.setAppLoading(true);
    final Map<String, dynamic> query = {ApiKey.view: true};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    var response = await getMethod<GemstoneDatum>(
      ApiClient.gemstoneDetails(id),
      query: query,
      withCurrencyHeader: true,
    );
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For Getting Diamond You May Like by ID
  Future<Either<ErrorResponse, DiamondListingModel>?> getDiamondYouMayLike(String id,
      {required String limit, required String page, bool isShowLoader = true}) async {
    if (isShowLoader) {
      context.setAppLoading(true);
    }
    final Map<String, dynamic> query = {ApiKey.page: page, ApiKey.limit: limit};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    var response = await getMethod<DiamondListingModel>(
      ApiClient.diamondYouMayLike(id),
      query: query,
      withCurrencyHeader: true,
    );
    if (isShowLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Getting Unique Shapes
  Future<Either<ErrorResponse, List<OrionShapeModel>>?> fetchUniqueShapes() async {
    var response = await getMethod<OrionShapeModel>(ApiClient.uniqueShapes);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Getting Watchlist Data
  Future<Either<ErrorResponse, PaginationData<WatchlistData>>?> getWatchList(
      {required String limit,
      required String page,
      bool isLoadMore = false,
      String searchQuery = '',
      bool isFullList = false,
      Map<String, dynamic>? filterQuery}) async {
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
              if (filterQuery != null) ...filterQuery
            },
      withCurrencyHeader: true,
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

  // For Submit Contact
  Future<Either<ErrorResponse, CommonResponse>?> submitContactUs({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    Either<ErrorResponse, dynamic>? response =
        await postMethod<Map<String, dynamic>>(ApiClient.submitContactUs, body, withFullResponse: true);
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
    if (isLoadMore) context.setAppLoading(true);
    final Map<String, dynamic> query = {ApiKey.page: page, ApiKey.limit: limit};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    var response = await getMethod<GemstoneListingModel>(
      ApiClient.gemstoneYouMayAlsoLike(id),
      query: query,
      withCurrencyHeader: true,
    );
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///For Getting Jewellery You May Like by ID
  Future<Either<ErrorResponse, JewelleryListingModel>?> getJewelleryYouMayLike(String id,
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    final Map<String, dynamic> query = {ApiKey.page: page, ApiKey.limit: limit};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    var response = await getMethod<JewelleryListingModel>(
      ApiClient.jewelleryYouMayAlsoLike(id),
      query: query,
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
    var response = await getMethod<WatchlistData>(ApiClient.watchListById(id), withCurrencyHeader: true);
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
  Future<Either<ErrorResponse, ProductReviewWrapperModel>?> productReviewsFilter(String productId,
      {Map<String, dynamic>? query, bool isLoadMore = true}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<ProductReviewWrapperModel>(ApiClient.productReviewsFilter(productId), query: query);
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
  Future<Either<ErrorResponse, CommonResponse>?> deleteBag({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await deleteMethod<Map<String, dynamic>>(ApiClient.deleteBag, withFullResponse: true, body: body);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, JewelleryListingModel>?> getRecentlyViewedProductList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    Map<String, dynamic>? query;

    String? suids;
    if (StorageManager.instance.getIsSkipLogin()) {
      suids = StorageManager.instance.getRecentlyViewedJewellery();
    }
    if (suids != null) {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.suid: suids, ApiKey.quote: StorageManager.instance.getBagId()};
    } else {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"};
    }
    var response = await getMethod<JewelleryListingModel>(
      ApiClient.jewelleryListing,
      query: query,
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //For Getting Product Details by ID
  Future<Either<ErrorResponse, JewelleryDataModel>?> getProductDetailById(String id, {bool isLoadingShow = true}) async {
    final Map<String, dynamic> query = {ApiKey.view: true};

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    if (isLoadingShow) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryDataModel>(
      ApiClient.productDetails(id),
      query: query,
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
    Map<String, dynamic>? query;
    String? suids;
    if (StorageManager.instance.getIsSkipLogin()) {
      suids = StorageManager.instance.getRecentlyViewedDiamond();
    }
    if (suids != null) {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.suid: suids};
    } else {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"};
    }
    var response = await getMethod<DiamondListingModel>(
      ApiClient.diamondListing,
      query: query,
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
    Map<String, dynamic>? query;
    String? suids;
    if (StorageManager.instance.getIsSkipLogin()) {
      suids = StorageManager.instance.getRecentlyViewedGemstone();
    }
    if (suids != null) {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.suid: suids};
    } else {
      query = {ApiKey.page: page, ApiKey.limit: limit, ApiKey.customFilter: "frequently-viewed-products"};
    }
    var response = await getMethod<GemstoneListingModel>(
      ApiClient.gemstoneListing,
      query: query,
      withCurrencyHeader: true,
    );
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // mergeBag
  Future<Either<ErrorResponse, CommonResponse>?> mergeBag({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await putMethod<Map<String, dynamic>>(ApiClient.mergeBag, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Collections listing
  Future<Either<ErrorResponse, PaginationData<CollectionDataItemsModel>>?> collectionMasterList(
      {required Map<String, dynamic> body, bool isLoadMore = false}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response = await getMethod<PaginationData<CollectionDataItemsModel>>(ApiClient.collectionMaster, query: body);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  //fetchOrionList
  Future<Either<ErrorResponse, PaginationData<DiamondDataModel>>?> fetchOrionList(bool isLoadMore,
      {required Map<String, dynamic> body}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<PaginationData<DiamondDataModel>>(ApiClient.orionList, query: body, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Gemstone Filter Option
  Future<Either<ErrorResponse, List<FilterOptionModel>>?> fetchFilterOptionList({required String type}) async {
    var response = await getMethod<FilterOptionModel>(ApiClient.filterOptions(type), withCurrencyHeader: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Gemstone Filter Secondary Option
  Future<Either<ErrorResponse, List<SecondaryFilterModel>>?> getSecondaryFilterData({required String slug, required String codes}) async {
    var response = await getMethod<SecondaryFilterModel>(ApiClient.secondaryFilterOptions(slug, codes));
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // Fetch Bag List Data
  Future<Either<ErrorResponse, BagListDataModel>?> getBagListData({required String id, bool isShowLoader = false}) async {
    if (isShowLoader) {
      context.setAppLoading(true);
    }
    var response = await getMethod<BagListDataModel>(ApiClient.bagListData, query: {ApiKey.id_: id}, withCurrencyHeader: true);
    if (isShowLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // getLanguageList
  Future<Either<ErrorResponse, LanguageListModel>?> getLanguageList({required Map<String, dynamic> body}) async {
    var response = await postMethod<LanguageListModel>(ApiClient.languageList, body);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, List<CountryStateModel>>?> fetchCountryList({bool isShowLoader = true}) async {
    if (isShowLoader) context.setAppLoading(true);
    var response = await getMethod<CountryStateModel>(ApiClient.countryMasters);
    if (isShowLoader) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, List<CountryStateModel>>?> fetchStateByCountry(
      {required String countryCode, bool isShowLoader = true}) async {
    if (isShowLoader) context.setAppLoading(true);
    var response = await getMethod<CountryStateModel>(ApiClient.stateMasters(countryCode));
    if (isShowLoader) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Save Address
  Future<Either<ErrorResponse, CommonResponse<AddressDetails>>?> saveAddress({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<AddressDetails>(ApiClient.customerAddress, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // For Get Address List
  Future<Either<ErrorResponse, List<AddressDetails>>?> fetchAddressList({bool isShowLoader = true}) async {
    if (isShowLoader) context.setAppLoading(true);
    var response = await getMethod<AddressDetails>(ApiClient.customerAddressFilters);
    if (isShowLoader) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // Update Address
  Future<Either<ErrorResponse, CommonResponse>?> updateAddress(String addressId, {required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await putMethod<Map<String, dynamic>>(ApiClient.customerAddressById(addressId), body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // Delete Address by ID
  Future<Either<ErrorResponse, CommonResponse>?> deleteAddress(String addressId) async {
    context.setAppLoading(true);
    var response = await deleteMethod<Map<String, dynamic>>(ApiClient.customerAddressById(addressId), withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<CadLibraryListItemDataModel>>?> getCadLibraryList(
      {Map<String, dynamic>? query, bool isLoadMore = true}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response =
        await getMethod<PaginationData<CadLibraryListItemDataModel>>(ApiClient.cadLibraryListing, query: query, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<CadLibraryListItemDataModel>>?> getStyleLibraryList(
      {Map<String, dynamic>? query, bool isLoadMore = true}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response =
        await getMethod<PaginationData<CadLibraryListItemDataModel>>(ApiClient.styleLibraryListing, query: query, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<DigitalCatalogueDetails>>?> digitalCatalogueFilters(
      {required Map<String, dynamic> body, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await postMethod<PaginationData<DigitalCatalogueDetails>>(ApiClient.digitalCatalogueFilters, body);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, List<Map<String, dynamic>>>?> compareProducts({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<Map<String, dynamic>>(ApiClient.compareProducts, body, withCurrencyHeader: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // getAuctionDetails
  Future<Either<ErrorResponse, AuctionDataModel>?> getAuctionDetails({required String id, bool isShowLoader = true}) async {
    if (isShowLoader) context.setAppLoading(true);
    var response = await getMethod<AuctionDataModel>(ApiClient.auctionDetails(id), withCurrencyHeader: true);
    if (isShowLoader) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<DesignLibraryListItemDataModel>>?> getDesignLibraryList({Map<String, dynamic>? query}) async {
    var response = await getMethod<PaginationData<DesignLibraryListItemDataModel>>(ApiClient.designLibraryListing,
        query: query, withCurrencyHeader: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<SkuLibraryListItemDataModel>>?> getSkuLibraryList({Map<String, dynamic>? query}) async {
    var response =
        await getMethod<PaginationData<SkuLibraryListItemDataModel>>(ApiClient.skuLibraryListing, query: query, withCurrencyHeader: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PreviewCatalogueDataModel>?> getPreviewCatalogue({required String id}) async {
    context.setAppLoading(true);
    var response = await getMethod<PreviewCatalogueDataModel>(ApiClient.digitalCatalogueById(id), withCurrencyHeader: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<CommentsAddedResponseModel>>?> digitalCatalogueAddComment(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await postMethod<CommentsAddedResponseModel>(ApiClient.digitalCatalogueAddComment, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommentsAddedResponseModel>?> getPreviewCatalogueCommentList(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await getMethod<CommentsAddedResponseModel>(ApiClient.previewCatalogueCommentsList, query: body);
    context.setAppLoading(false);

    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<ShapeMasterDetails>>?> shapeMasterFilters(
      {Map<String, dynamic>? body, bool isShowLoader = false}) async {
    if (isShowLoader) {
      context.setAppLoading(true);
    }
    var response = await postMethod<PaginationData<ShapeMasterDetails>>(ApiClient.shapeMasterFilters, body);
    if (isShowLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<HomeNewLanuchesDatum>>?> homePageNewlyLaunches({bool isLoadMore = false}) async {
    var response = await getMethod<PaginationData<HomeNewLanuchesDatum>>(ApiClient.homePageNewlyLaunches,
        query: {ApiKey.limit: AppConst.pageLimit10, ApiKey.page: AppConst.page1});
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  ///fetchMetalShapeData
  Future<Either<ErrorResponse, PaginationData<MetalShapeModel>>?> fetchMetalShapeData() async {
    var response = await getMethod<PaginationData<MetalShapeModel>>(ApiClient.homePageShopByMetals,
        query: {ApiKey.limit: AppConst.pageLimit10, ApiKey.page: AppConst.page1});
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<CommodityMasterDetails>>?> commodityMasterFilters(
      {Map<String, dynamic>? body, bool isShowLoader = false}) async {
    if (isShowLoader) {
      context.setAppLoading(true);
    }
    var response = await postMethod<PaginationData<CommodityMasterDetails>>(ApiClient.commodityMasterFilters, body);
    if (isShowLoader) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // get Sorting List
  Future<Either<ErrorResponse, List<SortOptionsModel>>?> getSortingOptions() async {
    var response = await getMethod<SortOptionsModel>(ApiClient.sortingData);
    return response?.fold((error) => Left(error), (sortOptions) => Right(sortOptions as List<SortOptionsModel>));
  }

  // For Wishlist Filter Option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchWishlistFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.wishlistFilterOptions);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// Find a Retail Store near your Location
  Future<Either<ErrorResponse, PaginationData<RetailStoreModel>>?> getRetailStore({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<PaginationData<RetailStoreModel>>(ApiClient.findRetailerStore, body);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, List<CustomerSalesmanModel>>?> customerSalesman() async {
    var response = await getMethod<CustomerSalesmanModel>(ApiClient.customerSalesman);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, BagOrderSummaryDataModel>?> getBagOrderSummaryData({required String id}) async {
    var response = await getMethod<BagOrderSummaryDataModel>(ApiClient.bagOrderSummaryById(id), withCurrencyHeader: true);

    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> applyPromoCode(Map<String, dynamic> body) async {
    var response = await postMethod<Map<String, dynamic>>(ApiClient.applyPromoCode, body, withFullResponse: true, withCurrencyHeader: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> removePromoCode({required String bagId}) async {
    var response = await deleteMethod<Map<String, dynamic>>(
      ApiClient.removePromoCode(bagId),
      withFullResponse: true,
    );
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, JewelleryListingModel>?> getJewelleryDealOfTheDayProductList(
      {required String limit, required String page, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<JewelleryListingModel>(ApiClient.jewelleryDealOfTheDay,
        query: {ApiKey.page: page, ApiKey.limit: limit}, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, JewelleryListingModel>?> homePageKgkCoutureCollectionsForJewelleryListing(
      {required String limit, required String page, bool isLoadMore = false, String? kgkCollection}) async {
    if (!isLoadMore) context.setAppLoading(true);
    var response = await getMethod<JewelleryListingModel>(
      ApiClient.homePageKgkCoutureCollections,
      query: {
        ApiKey.limit: limit,
        ApiKey.page: page,
        if (kgkCollection != null) ApiKey.kgkCollection: kgkCollection,
      },
      withCurrencyHeader: true,
    );
    if (!isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<KgkCoutureDetails>>?> homePageKgkCoutureCollections({
    required String limit,
    required String page,
    bool isLoadMore = false,
    String? kgkCollection,
  }) async {
    if (!isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await getMethod<PaginationData<KgkCoutureDetails>>(
      ApiClient.homePageKgkCoutureCollections,
      query: {
        ApiKey.limit: limit,
        ApiKey.page: page,
        if (kgkCollection != null) ApiKey.kgkCollection: kgkCollection,
      },
      withCurrencyHeader: true,
    );
    if (!isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, DiamondListingModel>?> getDiamondDealOfTheDayProductList(
      {Map<String, String>? query, bool isLoadMore = false}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response = await getMethod<DiamondListingModel>(ApiClient.rmDealOfTheDay, query: query, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  Future<Either<ErrorResponse, GemstoneListingModel>?> getGemstoneDealOfTheDayProductList(
      {Map<String, String>? query, bool isLoadMore = false}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response = await getMethod<GemstoneListingModel>(ApiClient.rmDealOfTheDay, query: query, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<Map<String, dynamic>>>?> checkoutStatus() async {
    context.setAppLoading(true);
    var response = await getMethod<Map<String, dynamic>>(ApiClient.checkoutStatus, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> bagUserAddress(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await putMethod<Map<String, dynamic>>(ApiClient.bagUserAddress, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<PlaceOrderResponse>>?> orderIndividual({Map<String, dynamic> body = const {}}) async {
    context.setAppLoading(true);
    var response = await postMethod<PlaceOrderResponse>(ApiClient.orderIndividual, body, withFullResponse: true, withCurrencyHeader: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse>?> updateBagItem(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await updateMethod<Map<String, dynamic>>(ApiClient.bag, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For DigitalCatalogue Filter Option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchDigitalCatalogueFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.digitalCatalogueFilterOptions);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Auction listing filter option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchAuctionListingFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.auctionListingFilterOption);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Watch listing filter option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchWatchListingFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.watchListFilterOptions);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<PaymentCondition>>?> getPaymentTermsFilter({Map<String, dynamic>? body}) async {
    var response = await postMethod<PaginationData<PaymentCondition>>(ApiClient.paymentTermsFilter, body);

    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<PlaceOrderResponse>>?> placeB2BOrder(Map<String, dynamic> body) async {
    context.setAppLoading(true);
    var response = await postMethod<PlaceOrderResponse>(ApiClient.placeB2BOrder, body, withFullResponse: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<OrderItem>>?> getMyOrderList({Map<String, dynamic>? body, bool isLoadMore = false}) async {
    if (isLoadMore) context.setAppLoading(true);
    var response = await getMethod<PaginationData<OrderItem>>(ApiClient.myOrders, query: body, withCurrencyHeader: true);
    if (isLoadMore) context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For order listing filter option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchOrderListingFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.orderFilterList);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// Get a Calendar Events
  Future<Either<ErrorResponse, List<CalendarDataModel>>?> getCalenderEvent({required Map<String, dynamic> body}) async {
    context.setAppLoading(true);
    var response = await postMethod<CalendarDataModel>(ApiClient.getCalenderEvents, body);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// Get a Calendar Event Details
  Future<Either<ErrorResponse, CalenderEventDetailsDataModel>?> getCalenderEventDetails({required String id}) async {
    context.setAppLoading(true);
    var response = await getMethod<CalenderEventDetailsDataModel>(ApiClient.getCalenderEventDetailsById(id));
    context.setAppLoading(false);

    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// Get Exhibition Listing Data
  Future<Either<ErrorResponse, PaginationData<ExhibitionListDataModel>>?> getExhibitionListing({required Map<String, dynamic> body}) async {
    var response = await postMethod<PaginationData<ExhibitionListDataModel>>(ApiClient.getExhibitionList, body);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// Get Exhibition Listing Data by Locations
  Future<Either<ErrorResponse, PaginationData<ExhibitionListLocationDataModel>>?> getExhibitionListingByLocations() async {
    var response = await getMethod<PaginationData<ExhibitionListLocationDataModel>>(ApiClient.getExhibitionListByLocations);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, DiamondListingModel>?> diyFilters({
    required String limit,
    required String page,
    String? sortKey,
    String? sortValue,
    bool isLoadMore = false,
    Map<String, String>? query,
    String? type,
  }) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    Map<String, String> queryParams = {
      ApiKey.limit: limit,
      ApiKey.page: page,
      if (sortKey.isNotNullNorEmpty) ApiKey.sortKey: sortKey!,
      if (sortValue.isNotNullNorEmpty) ApiKey.sortValue: sortValue!,
      if (type.isNotNullNorEmpty) ApiKey.type: type!,
    };
    if (query != null) {
      queryParams.addAll(query);
    }

    var response = await getMethod<DiamondListingModel>(ApiClient.diyFilters, query: queryParams, withCurrencyHeader: true);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((error) => Left(error), (r) => Right(r));
  }

  Future<Either<ErrorResponse, DiamondDataModel>?> diyDetails({required String id}) async {
    context.setAppLoading(true);
    var response = await getMethod<DiamondDataModel>(ApiClient.diyDetails(id), withCurrencyHeader: true);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  // fetchInquiryType
  Future<Either<ErrorResponse, List<String>>?> fetchInquiryType() async {
    context.setAppLoading(true);
    var response = await getMethod<String>(ApiClient.inquiryType);
    context.setAppLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<PlaceOrderResponse>>?> orderDetailsApiCall({required String id}) async {
    var response = await getMethod<PlaceOrderResponse>(ApiClient.orderDetails(id), withCurrencyHeader: true, withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<DiyStyleListModel>>?> diyStyleFilters({
    required String limit,
    required String page,
    required String sortKey,
    required String sortValue,
    bool isLoadMore = false,
    Map<String, String>? query,
  }) async {
    Map<String, String> queryParams = {
      ApiKey.limit: limit,
      ApiKey.page: page,
    };
    if (query != null) {
      queryParams.addAll(query);
    }

    if (!isLoadMore) {
      context.setAppLoading(true);
    }
    var response =
        await getMethod<PaginationData<DiyStyleListModel>>(ApiClient.diyStyleFilters, query: queryParams, withCurrencyHeader: true);
    if (!isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Exhibition listing filter option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchExhibitionListingFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.getExhibitionFilterListOption);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Exhibition Details page
  Future<Either<ErrorResponse, ExhibitionListDataModel>?> fetchExhibitionDetails({required String id}) async {
    var response = await getMethod<ExhibitionListDataModel>(ApiClient.getExhibitionDetails(id));
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For Exhibition Product Details page
  Future<Either<ErrorResponse, ExhibitionProductDetailsDataModel>?> fetchExhibitionProductDetails({
    required String id,
  }) async {
    var response = await getMethod<ExhibitionProductDetailsDataModel>(ApiClient.getExhibitionProductsDetails,
        query: {ApiKey.orderContextId: id}, withCurrencyHeader: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, CommonResponse<ApplyPromoCodeModel>>?> fetchPromoCodeList() async {
    var response = await getMethod<ApplyPromoCodeModel>(ApiClient.promoCodeList, withFullResponse: true);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, PaginationData<PddDataModel>>?> getPresentationFilters(
      {required Map<String, dynamic> body, bool isLoadMore = false}) async {
    if (isLoadMore) {
      context.setAppLoading(true);
    }
    var response = await postMethod<PaginationData<PddDataModel>>(ApiClient.presentationFilters, body);
    if (isLoadMore) {
      context.setAppLoading(false);
    }
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  /// For DigitalCatalogue Filter Option
  Future<Either<ErrorResponse, AdvanceFilterOptionModel>?> fetchPddListingFilterOptionList() async {
    var response = await getMethod<AdvanceFilterOptionModel>(ApiClient.pddFilterOptions);
    return response?.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<ErrorResponse, DiyFinalDetailsModel>?> getDiySettingDetails(String settingId, {Map<String, dynamic>? query}) async {
    context.setAppLoading(true);

    var response = await getMethod<DiyFinalDetailsModel>(ApiClient.diyStyleDetails(settingId), query: query, withCurrencyHeader: true);

    context.setAppLoading(false);
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
