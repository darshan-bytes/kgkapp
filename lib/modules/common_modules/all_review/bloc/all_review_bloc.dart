import 'package:kgk/kgk.dart';

part 'all_review_event.dart';

part 'all_review_state.dart';

class AllReviewBloc extends Bloc<AllReviewEvent, AllReviewState> {
  List<ReviewDataModel> reviewList = [];
  List<ProductReviewModel> productReviewListAPI = [];
  String productId = '';
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  AllReviewBloc() : super(AllReviewInitial()) {
    on<AllReviewInitialEvent>(_onAllReviewInitialEvent);
    on<AllReviewLoadMoreEvent>(_onAllReviewLoadMoreEvent);
  }

  Future<void> _onAllReviewInitialEvent(AllReviewInitialEvent event, Emitter<AllReviewState> emit) async {
    emit(const ReloadAllReviewState());
    productId = event.context.routesData?[RoutesData.productId] ?? '';
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(AllReviewLoadMoreEvent(currentPage, event.context));
      },
    );
    reviewList.clear();
    productReviewListAPI.clear();
    emit(const AllReviewLoadingState());
    await productReviewsFilter(event.context, productId);

    emit(const AllReviewLoadedState());
  }

  Future<void> _onAllReviewLoadMoreEvent(AllReviewLoadMoreEvent event, Emitter<AllReviewState> emit) async {
    emit(const AllReviewLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    await productReviewsFilter(event.context, productId);
    emit(const AllReviewLoadedMoreState());
  }

  Future<void> productReviewsFilter(BuildContext context, String productId) async {
    Map<String, dynamic> query = {
      ApiKey.productId_: productId,
      ApiKey.limit: AppConst.pageLimit,
      ApiKey.page: paginationScrollController.currentPage,
    };
    Either<ErrorResponse, ProductReviewWrapperModel>? response = await AppRepository(context).productReviewsFilter(query: query);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        totalNumberOfPages = Utils.calculateTotalPages(data.filteredRecords, AppConst.pageLimit);
        List<ProductReviewModel> localList = data.dataList ?? [];
        productReviewListAPI.addAll(localList);
        for (ProductReviewModel e in localList) {
          reviewList.add(ReviewDataModel(
            id: e.id,
            userName: e.userIdDetails?.fullName ?? '',
            date: e.createdAt?.changeDateFormat(
                    inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ, outputDateFormat: DateFormatter.dateFormatDDMMYYYY) ??
                '',
            rating: e.rating ?? 0,
            title: e.title ?? '',
            review: e.description ?? '',
            images: e.displayImage ?? [],
          ));
        }
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      },
    );
  }
}
