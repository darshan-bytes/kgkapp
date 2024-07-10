import 'package:kgk/kgk.dart';

part 'messages_event.dart';

part 'messages_state.dart';

enum MessagesTab {
  inbox,
  sent,
  draft,
  favourite,
  trash,
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  late TabController tabController;

  TextEditingController inboxSearchController = TextEditingController();
  TextEditingController sentSearchController = TextEditingController();
  TextEditingController draftSearchController = TextEditingController();
  TextEditingController favouriteSearchController = TextEditingController();
  TextEditingController trashSearchController = TextEditingController();

  List<MessagesModel> inboxList = [], sentList = [], draftList = [], favouriteList = [], trashList = [];

  SmartPaginationScrollController inboxScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController sentScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController draftScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController favouriteScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController trashScrollController = SmartPaginationScrollController();

  @override
  Future<void> close() {
    inboxScrollController.dispose();
    sentScrollController.dispose();
    draftScrollController.dispose();
    favouriteScrollController.dispose();
    trashScrollController.dispose();
    return super.close();
  }

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.inbox.tr),
    Tab(text: APPStrings.sent.tr),
    Tab(text: APPStrings.draft.tr),
    Tab(text: APPStrings.favourite.tr),
    Tab(text: APPStrings.trash.tr),
  ];

  MessagesBloc() : super(MessagesInitial()) {
    on<MessagesInitialEvent>(_onMessageInitialEvent);
    on<MessagesLoadMoreEvent>(_onLoadMoreEvent);
    on<MessagesTabChangeEvent>(_onTabChangedEvent);
  }

  void _onMessageInitialEvent(MessagesInitialEvent event, Emitter<MessagesState> emit) {
    inboxScrollController.init(
        tag: "inboxScrollController",
        loadAction: (int currentPage) {
          add(MessagesLoadMoreEvent(currentPage: currentPage, listType: MessagesTab.inbox));
        });

    sentScrollController.init(
        tag: "sentScrollController",
        loadAction: (int currentPage) {
          add(MessagesLoadMoreEvent(currentPage: currentPage, listType: MessagesTab.sent));
        });

    draftScrollController.init(
        tag: "draftScrollController",
        loadAction: (int currentPage) {
          add(MessagesLoadMoreEvent(currentPage: currentPage, listType: MessagesTab.draft));
        });

    favouriteScrollController.init(
        tag: "favouriteScrollController",
        loadAction: (int currentPage) {
          add(MessagesLoadMoreEvent(currentPage: currentPage, listType: MessagesTab.favourite));
        });

    trashScrollController.init(
        tag: "trashScrollController",
        loadAction: (int currentPage) {
          add(MessagesLoadMoreEvent(currentPage: currentPage, listType: MessagesTab.trash));
        });

    inboxList = List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet consecte. Massa fringilla elemen at maecenas enim sapien.",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));

    sentList = List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));

    draftList = List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));

    favouriteList = List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));

    trashList = List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));

    emit(const MessagesLoadedState());
  }

  void _onTabChangedEvent(MessagesTabChangeEvent event, Emitter<MessagesState> emit) {
    emit(const MessagesReloadState());
    final MessagesTab tab = MessagesTab.values[tabController.index];

    switch (tab) {
      case MessagesTab.inbox:
        // inbox logic
        break;
      case MessagesTab.sent:
        // sent logic
        break;
      case MessagesTab.draft:
        // draft logic
        break;
      case MessagesTab.favourite:
        // favourite logic
        break;
      case MessagesTab.trash:
        // trash logic
        break;
    }

    emit(const MessagesOnTabChangedState());
  }

  void _onLoadMoreEvent(MessagesLoadMoreEvent event, Emitter<MessagesState> emit) async {
    emit(MessagesLoadingMoreState(listType: event.listType));
    await Future.delayed(const Duration(seconds: 2));

    List<MessagesModel> newList = [];

    switch (event.listType) {
      case MessagesTab.inbox:
        newList = generateIndexData();
        inboxList.addAll(newList);
        inboxScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MessagesTab.sent:
        newList = generateSentData();
        sentList.addAll(newList);
        sentScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MessagesTab.draft:
        newList = generateDraftData();
        draftList.addAll(newList);
        draftScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MessagesTab.favourite:
        newList = generateFavouriteData();
        favouriteList.addAll(newList);
        favouriteScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MessagesTab.trash:
        newList = generateTrashData();
        trashList.addAll(newList);
        trashScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
    }

    emit(MessagesLoadedMoreState(currentPage: event.currentPage + 1, listType: event.listType));
  }

  // Getter for the current list based on the selected tab
  List<MessagesModel> get currentList {
    final MessagesTab currentTab = MessagesTab.values[tabController.index];
    switch (currentTab) {
      case MessagesTab.inbox:
        return inboxList;
      case MessagesTab.sent:
        return sentList;
      case MessagesTab.draft:
        return draftList;
      case MessagesTab.favourite:
        return favouriteList;
      case MessagesTab.trash:
        return trashList;
      default:
        return []; // Default case
    }
  }

  SmartPaginationScrollController get currentController {
    final MessagesTab currentTab = MessagesTab.values[tabController.index];
    switch (currentTab) {
      case MessagesTab.inbox:
        return inboxScrollController;
      case MessagesTab.sent:
        return sentScrollController;
      case MessagesTab.draft:
        return draftScrollController;
      case MessagesTab.favourite:
        return favouriteScrollController;
      case MessagesTab.trash:
        return trashScrollController;
    }
  }

  // Method to build the list view widget based on the selected tab
  Widget buildListView(BuildContext context, MessagesTab currentTab) {
    return Expanded(
      child: BlocBuilder<MessagesBloc, MessagesState>(
        buildWhen: (previous, current) => current is MessagesLoadedState || current is MessagesLoadedMoreState,
        builder: (context, state) {
          if (currentList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noPresentationFound.tr); // Adjust text based on the selected tab if necessary
          }
          return ListView.separated(
            itemCount: currentList.length,
            controller: currentController.scrollController,
            padding: EdgeInsets.only(bottom: 24.h),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return BlocBuilder<MessagesBloc, MessagesState>(
                buildWhen: (previous, current) => current is MessagesLoadingMoreState || current is MessagesLoadedMoreState,
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildListTile(context, currentList[index]),
                      if (state is MessagesLoadingMoreState && index == currentList.length - 1) const SmartCircularProgressIndicator(),
                    ],
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 32.h,
              child: const Center(
                child: Divider(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context, MessagesModel model) {
    final MessagesStyle style = AppTheme.of(context).messagesStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartImage(
          path: model.userImageUrl ?? '',
          height: 32.w,
          width: 32.w,
          imageBorderRadius: BorderRadius.circular(50.r),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SmartText(
                      model.userName,
                      style: style.userNameStyle,
                    ),
                  ),
                  SmartText(
                    model.timeAgo,
                    style: style.timeAgoStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SmartText(
                      model.message,
                      style: style.messagesStyle,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Icon(
                      model.isFavorite ? Icons.star : Icons.star_border,
                      color: model.isFavorite ? style.primaryColor : style.color8C8C8C,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<MessagesModel> generateIndexData() {
    return List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));
  }

  List<MessagesModel> generateSentData() {
    return List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));
  }

  List<MessagesModel> generateDraftData() {
    return List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));
  }

  List<MessagesModel> generateFavouriteData() {
    return List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));
  }

  List<MessagesModel> generateTrashData() {
    return List.generate(
        10,
        (index) => MessagesModel(
              id: index.toString(),
              isFavorite: index % 2 == 0,
              message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut",
              timeAgo: "2 days ago",
              userImageUrl: "https://picsum.photos/200/300",
              userName: "John Doe",
            ));
  }

  List<Widget> buildTabBarView(MessagesBloc bloc) {
    return [
      InboxTabviewListTile(messagesBloc: bloc),
      SentTabviewListTile(messagesBloc: bloc),
      DraftTabviewListTile(messagesBloc: bloc),
      FavouriteTabviewListTile(messagesBloc: bloc),
      TrashTabviewTileListTile(messagesBloc: bloc),
    ];
  }
}
