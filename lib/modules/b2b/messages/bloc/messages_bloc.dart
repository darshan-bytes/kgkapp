import 'package:kgk/kgk.dart';

part 'messages_event.dart';

part 'messages_state.dart';

enum MessagesTab {
  inbox,
  sent,
  favourite,
  trash,
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  late TabController tabController;

  TextEditingController inboxSearchController = TextEditingController();
  TextEditingController sentSearchController = TextEditingController();
  TextEditingController favouriteSearchController = TextEditingController();
  TextEditingController trashSearchController = TextEditingController();

  List<MessagesModel> inboxList = [], sentList = [], favouriteList = [], trashList = [];

  SmartPaginationScrollController inboxScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController sentScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController favouriteScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController trashScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  @override
  Future<void> close() {
    inboxScrollController.dispose();
    sentScrollController.dispose();
    favouriteScrollController.dispose();
    trashScrollController.dispose();
    return super.close();
  }

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.inbox.tr),
    Tab(text: APPStrings.sent.tr),
    Tab(text: APPStrings.favourite.tr),
    Tab(text: APPStrings.trash.tr),
  ];

  MessagesBloc() : super(MessagesInitial()) {
    on<MessagesInitialEvent>(_onMessageInitialEvent);
    on<MessagesLoadMoreEvent>(_onLoadMoreEvent);
    on<MessagesTabChangeEvent>(_onTabChangedEvent);
    on<MessagesFavouriteToggleEvent>(_onFavouriteToggleEvent);
    on<MessagesPullToRefreshEvent>(_onPullToRefreshEvent);
  }

  void _onMessageInitialEvent(MessagesInitialEvent event, Emitter<MessagesState> emit) {
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
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

    String msg =
        "Lorem ipsum dolor sit amet consectetur. Mattis a faucibus quis nunc egestas ipsum. Lectus sem vitae orci lorem tristique amet. Nibh ut elementum nibh arcu adipiscing est. Dui nulla massa eu quis arcu lacus. Dolor dignissim non mi ornare. Ac in at amet blandit commodo velit lorem ornare. Molestie velit lorem aliquam nisi sed. Nulla consequat a aenean habitasse convallis vulputate. Pulvinar scelerisque tempor lectus commodo. \n\nLorem ipsum dolor sit amet consectetur. Id pharetra interdum ullamcorper condimentum. Accumsan ut mauris volutpat purus in. Viverra risus a sed tristique venenatis mi dolor accumsan malesuada. Sit elementum tortor commodo diam dignissim facilisis habitant eu.";

    inboxList = List.generate(
        10,
        (index) => MessagesModel(
            id: index.toString(),
            isFavorite: index % 2 == 0,
            message: "Lorem ipsum dolor sit amet consecte. Massa fringilla elemen at maecenas enim sapien.",
            timeAgo: "2 days ago",
            userImageUrl: "https://picsum.photos/200/300",
            userName: "Alex Williams",
            fullMessage: msg,
            details: List.generate(
              4,
              (index) => MessagesDetailsModel(
                  id: index.toString(),
                  userName: "Alex Williams",
                  userImageUrl: index % 2 == 0 ? "https://i.ibb.co/SJDj2Pj/Frame-3977.png" : "https://picsum.photos/200/300",
                  timeAgo: "2 days ago",
                  toMe: index % 2 != 0,
                  fullMessage: msg,
                  toUserName: "Michael Lee",
                  messageDetailsKey: GlobalKey<SmartExpansionTileState>()),
            )));

    sentList = List.generate(
        10,
        (index) => MessagesModel(
            id: index.toString(),
            isFavorite: index % 2 == 0,
            message: "Lorem ipsum dolor sit amet consecte. Massa fringilla elemen at maecenas enim sapien.",
            timeAgo: "2 days ago",
            userImageUrl: "https://picsum.photos/200/300",
            userName: "Alex Williams",
            fullMessage: msg,
            details: List.generate(
              4,
              (index) => MessagesDetailsModel(
                  id: index.toString(),
                  userName: "Alex Williams",
                  userImageUrl: index % 2 == 0 ? "https://i.ibb.co/SJDj2Pj/Frame-3977.png" : "https://picsum.photos/200/300",
                  timeAgo: "2 days ago",
                  toMe: index % 2 != 0,
                  fullMessage: msg,
                  toUserName: "Michael Lee",
                  messageDetailsKey: GlobalKey<SmartExpansionTileState>()),
            )));

    favouriteList = List.generate(
        10,
        (index) => MessagesModel(
            id: index.toString(),
            isFavorite: true,
            message: "Lorem ipsum dolor sit amet consecte. Massa fringilla elemen at maecenas enim sapien.",
            timeAgo: "2 days ago",
            userImageUrl: "https://picsum.photos/200/300",
            userName: "Alex Williams",
            fullMessage: msg,
            details: List.generate(
              4,
              (index) => MessagesDetailsModel(
                  id: index.toString(),
                  userName: "Alex Williams",
                  userImageUrl: index % 2 == 0 ? "https://i.ibb.co/SJDj2Pj/Frame-3977.png" : "https://picsum.photos/200/300",
                  timeAgo: "2 days ago",
                  toMe: index % 2 != 0,
                  fullMessage: msg,
                  toUserName: "Michael Lee",
                  messageDetailsKey: GlobalKey<SmartExpansionTileState>()),
            )));

    trashList = List.generate(
        10,
        (index) => MessagesModel(
            id: index.toString(),
            isFavorite: index % 2 == 0,
            message: "Lorem ipsum dolor sit amet consecte. Massa fringilla elemen at maecenas enim sapien.",
            timeAgo: "2 days ago",
            userImageUrl: "https://picsum.photos/200/300",
            userName: "Alex Williams",
            fullMessage: msg,
            details: List.generate(
              4,
              (index) => MessagesDetailsModel(
                  id: index.toString(),
                  userName: "Alex Williams",
                  userImageUrl: index % 2 == 0 ? "https://i.ibb.co/SJDj2Pj/Frame-3977.png" : "https://picsum.photos/200/300",
                  timeAgo: "2 days ago",
                  toMe: index % 2 != 0,
                  fullMessage: msg,
                  toUserName: "Michael Lee",
                  messageDetailsKey: GlobalKey<SmartExpansionTileState>()),
            )));
    refreshCompleter.complete(true);
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

  Future<void> _onPullToRefreshEvent(MessagesPullToRefreshEvent event, Emitter<MessagesState> emit) async {
    emit(const MessagesReloadState());
    await Future.delayed(const Duration(seconds: 2));
    switch (event.listType) {
      case MessagesTab.inbox:
        inboxScrollController.pullToRefresh();
        inboxList = generateIndexData();
        break;
      case MessagesTab.sent:
        sentScrollController.pullToRefresh();
        sentList = generateSentData();
        break;
      case MessagesTab.favourite:
        favouriteScrollController.pullToRefresh();
        favouriteList = generateFavouriteData();
        break;
      case MessagesTab.trash:
        trashScrollController.pullToRefresh();
        trashList = generateTrashData();
        break;
    }
    refreshCompleter.complete(true);
    emit(const MessagesLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    final MessagesTab currentTab = MessagesTab.values[tabController.index];
    add(MessagesPullToRefreshEvent(listType: currentTab));
    bool result = await refreshCompleter.future;
    return result;
  }

  void _onFavouriteToggleEvent(MessagesFavouriteToggleEvent event, Emitter<MessagesState> emit) {
    final MessagesTab tab = MessagesTab.values[tabController.index];
    emit(const MessagesReloadState());
    if (tab == MessagesTab.favourite) {
      currentList.removeAt(event.index);
    } else {
      final MessagesModel model = currentList.firstWhere((element) => element.id == event.id);
      model.isFavorite = !model.isFavorite;
      currentList[event.index] = model;
    }
    emit(MessagesFavouriteToggleState(id: event.id));
  }

  // Getter for the current list based on the selected tab
  List<MessagesModel> get currentList {
    final MessagesTab currentTab = MessagesTab.values[tabController.index];
    switch (currentTab) {
      case MessagesTab.inbox:
        return inboxList;
      case MessagesTab.sent:
        return sentList;
      case MessagesTab.favourite:
        return favouriteList;
      case MessagesTab.trash:
        return trashList;
    }
  }

  SmartPaginationScrollController get currentController {
    final MessagesTab currentTab = MessagesTab.values[tabController.index];
    switch (currentTab) {
      case MessagesTab.inbox:
        return inboxScrollController;
      case MessagesTab.sent:
        return sentScrollController;
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
        buildWhen: (previous, current) =>
            current is MessagesLoadedState || current is MessagesLoadedMoreState || current is MessagesFavouriteToggleState,
        builder: (context, state) {
          if (currentList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noPresentationFound.tr); // Adjust text based on the selected tab if necessary
          }
          return SmartRefreshIndicator(
            onRefresh: () async {
              await pullToRefresh();
            },
            child: ListView.separated(
              itemCount: currentList.length,
              controller: currentController.scrollController,
              padding: EdgeInsetsDirectional.only(bottom: 24.h),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return BlocBuilder<MessagesBloc, MessagesState>(
                  buildWhen: (previous, current) =>
                      current is MessagesLoadingMoreState || current is MessagesLoadedMoreState || current is MessagesFavouriteToggleState,
                  builder: (context, state) {
                    return Column(
                      children: [
                        _buildListTile(context, currentList[index], index),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context, MessagesModel model, int index) {
    final MessagesStyle style = AppTheme.of(context).messagesStyle;
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.messagesDetailPage, arguments: {RoutesData.messageModel: model}),
      child: Row(
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
                    GestureDetector(
                      onTap: () {
                        add(MessagesFavouriteToggleEvent(id: model.id ?? "", index: index));
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 6.h),
                        child: Icon(
                          model.isFavorite ? Icons.star : Icons.star_border,
                          color: model.isFavorite ? style.primaryColor : style.color8C8C8C,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
      FavouriteTabviewListTile(messagesBloc: bloc),
      TrashTabviewTileListTile(messagesBloc: bloc),
    ];
  }
}
