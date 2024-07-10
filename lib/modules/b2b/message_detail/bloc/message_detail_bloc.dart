import 'package:kgk/kgk.dart';

part 'message_detail_event.dart';

part 'message_detail_state.dart';

class MessageDetailBloc extends Bloc<MessageDetailEvent, MessageDetailState> {
  MessagesModel? messagesModel;

  MessageDetailBloc() : super(MessageDetailInitial()) {
    on<MessageDetailInitialEvent>(_onMessageDetailInitialEvent);
    on<MessageShowFullMessageEvent>(_onMessageShowFullMessageEvent);
  }

  void _onMessageDetailInitialEvent(MessageDetailInitialEvent event, Emitter<MessageDetailState> emit) {
    emit(const MessageReloadState());
    Map<RoutesData, dynamic>? data = event.context.routesData;
    messagesModel = data?[RoutesData.messageModel] as MessagesModel;
    emit(const MessageDetailLoadedState());
  }

  void _onMessageShowFullMessageEvent(MessageShowFullMessageEvent event, Emitter<MessageDetailState> emit) {
    emit(const MessageReloadState());
    int oldIndex = -1;

    messagesModel?.details?[event.index].isExpanded = event.isExpanded;

    if (event.isExpanded) {
      for (int i = 0; i < messagesModel!.details!.length; i++) {
        if (i != event.index && messagesModel!.details![i].isExpanded) {
          oldIndex = i;
          messagesModel!.details![i].messageDetailsKey.currentState?.collapse();
          break;
        }
      }
    }

    emit(MessageShowFullMessageState(event.index, oldIndex, event.isExpanded));
  }
}
