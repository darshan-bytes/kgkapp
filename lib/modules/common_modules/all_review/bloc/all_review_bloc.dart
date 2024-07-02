import 'package:kgk/kgk.dart';

part 'all_review_event.dart';

part 'all_review_state.dart';

class AllReviewBloc extends Bloc<AllReviewEvent, AllReviewState> {
  List<ReviewDataModel> reviewDataModel = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  AllReviewBloc() : super(AllReviewInitial()) {
    on<AllReviewInitialEvent>(_onAllReviewInitialEvent);
    on<AllReviewLoadMoreEvent>(_onAllReviewLoadMoreEvent);
  }

  void _onAllReviewInitialEvent(AllReviewInitialEvent event, Emitter<AllReviewState> emit) {
    emit(const ReloadAllReviewState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(AllReviewLoadMoreEvent(currentPage));
      },
    );
    reviewDataModel.clear();
    emit(const AllReviewLoadingState());
    List.generate(
      20,
      (index) => reviewDataModel.add(
        ReviewDataModel(
          userName: "John Doe",
          date: "12th June 2021",
          rating: 4,
          title: "Good Product",
          review:
              'I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone.',
          images: index % 2 == 0 ? ["https://i.ibb.co/zZ6y0w4/image-7-4.png", "https://i.ibb.co/xStbncs/image-7-5.png"] : null,
        ),
      ),
    );

    emit(const AllReviewLoadedState());
  }

  Future<void> _onAllReviewLoadMoreEvent(AllReviewLoadMoreEvent event, Emitter<AllReviewState> emit) async {
    emit(const AllReviewLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    List.generate(
      20,
      (index) => reviewDataModel.add(
        ReviewDataModel(
          id: index + 1,
          userName: "John Doe",
          date: "12th June 2021",
          rating: 4,
          title: "Good Product",
          review:
              'I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone.',
          images: index % 2 == 0 ? ["https://i.ibb.co/zZ6y0w4/image-7-4.png", "https://i.ibb.co/xStbncs/image-7-5.png"] : null,
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 4);
    emit(const AllReviewLoadedMoreState());
  }
}
