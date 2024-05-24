import 'package:kgk/kgk.dart';

part 'diamond_detail_event.dart';
part 'diamond_detail_state.dart';

class DiamondDetailBloc extends Bloc<DiamondDetailEvent, DiamondDetailState> {
  final List<String> imgList = [
    "https://s3-alpha-sig.figma.com/img/4151/5fa2/9a07a407ea94d17e9b36b62cb558a6c5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DI-Rae48JKiJUK0hjScQ3GPC1kp5vCldQlIL9KcedkbUexeIpSHx6uYwXizmmuiyWIipv008T9TLsf1NwvsV3dO~Beho5rCbRPB9hMVRafy-g7eXN-L0uVZlJPNg93fdegijgfiyNJv45gXMlgLPEDoSAnmIOIjKqFM3L5P74tEtJugrUw9BFFWssPYjZtd5ae2xaG3VszkjtBm2Y5SdBgwfXLh1Xj3KQuWBRIiQU5zJRlXVUie~ELiM3QJ6tDoKZ333yfeUljHQOXzOJQ3FCOcP1N6Qe546kI06nRIWx3pg36RR4R8OU1g~MI~ayh9g7smNkZLJF0ccJsYYBNlo1A__",
    "https://s3-alpha-sig.figma.com/img/4151/5fa2/9a07a407ea94d17e9b36b62cb558a6c5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DI-Rae48JKiJUK0hjScQ3GPC1kp5vCldQlIL9KcedkbUexeIpSHx6uYwXizmmuiyWIipv008T9TLsf1NwvsV3dO~Beho5rCbRPB9hMVRafy-g7eXN-L0uVZlJPNg93fdegijgfiyNJv45gXMlgLPEDoSAnmIOIjKqFM3L5P74tEtJugrUw9BFFWssPYjZtd5ae2xaG3VszkjtBm2Y5SdBgwfXLh1Xj3KQuWBRIiQU5zJRlXVUie~ELiM3QJ6tDoKZ333yfeUljHQOXzOJQ3FCOcP1N6Qe546kI06nRIWx3pg36RR4R8OU1g~MI~ayh9g7smNkZLJF0ccJsYYBNlo1A__",
    "https://s3-alpha-sig.figma.com/img/4151/5fa2/9a07a407ea94d17e9b36b62cb558a6c5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DI-Rae48JKiJUK0hjScQ3GPC1kp5vCldQlIL9KcedkbUexeIpSHx6uYwXizmmuiyWIipv008T9TLsf1NwvsV3dO~Beho5rCbRPB9hMVRafy-g7eXN-L0uVZlJPNg93fdegijgfiyNJv45gXMlgLPEDoSAnmIOIjKqFM3L5P74tEtJugrUw9BFFWssPYjZtd5ae2xaG3VszkjtBm2Y5SdBgwfXLh1Xj3KQuWBRIiQU5zJRlXVUie~ELiM3QJ6tDoKZ333yfeUljHQOXzOJQ3FCOcP1N6Qe546kI06nRIWx3pg36RR4R8OU1g~MI~ayh9g7smNkZLJF0ccJsYYBNlo1A__",
    "https://s3-alpha-sig.figma.com/img/4151/5fa2/9a07a407ea94d17e9b36b62cb558a6c5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DI-Rae48JKiJUK0hjScQ3GPC1kp5vCldQlIL9KcedkbUexeIpSHx6uYwXizmmuiyWIipv008T9TLsf1NwvsV3dO~Beho5rCbRPB9hMVRafy-g7eXN-L0uVZlJPNg93fdegijgfiyNJv45gXMlgLPEDoSAnmIOIjKqFM3L5P74tEtJugrUw9BFFWssPYjZtd5ae2xaG3VszkjtBm2Y5SdBgwfXLh1Xj3KQuWBRIiQU5zJRlXVUie~ELiM3QJ6tDoKZ333yfeUljHQOXzOJQ3FCOcP1N6Qe546kI06nRIWx3pg36RR4R8OU1g~MI~ayh9g7smNkZLJF0ccJsYYBNlo1A__",
    "https://s3-alpha-sig.figma.com/img/4151/5fa2/9a07a407ea94d17e9b36b62cb558a6c5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DI-Rae48JKiJUK0hjScQ3GPC1kp5vCldQlIL9KcedkbUexeIpSHx6uYwXizmmuiyWIipv008T9TLsf1NwvsV3dO~Beho5rCbRPB9hMVRafy-g7eXN-L0uVZlJPNg93fdegijgfiyNJv45gXMlgLPEDoSAnmIOIjKqFM3L5P74tEtJugrUw9BFFWssPYjZtd5ae2xaG3VszkjtBm2Y5SdBgwfXLh1Xj3KQuWBRIiQU5zJRlXVUie~ELiM3QJ6tDoKZ333yfeUljHQOXzOJQ3FCOcP1N6Qe546kI06nRIWx3pg36RR4R8OU1g~MI~ayh9g7smNkZLJF0ccJsYYBNlo1A__",
  ];

  int current = 0;
  final CarouselController controller = CarouselController();

  DiamondDetailBloc() : super(DiamondDetailInitial()) {
    on<DiamondImagePageChangeEvent>((event, emit) {
      current = event.index;
      emit(DiamondImagePageChangeState());
      emit(DiamondDetailInitial());
    });
  }
}
