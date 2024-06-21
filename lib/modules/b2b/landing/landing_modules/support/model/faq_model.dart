class FaqWrapper {
  String? title;
  List<FAQ>? faqs;

  FaqWrapper({
    this.title,
    this.faqs,
  });

  @override
  bool operator ==(Object other) {
    return other is FaqWrapper && other.title == title && other.faqs == faqs;
  }

  @override
  int get hashCode => title.hashCode ^ faqs.hashCode;
}

class FAQ {
  String? question;
  String? answer;

  FAQ({
    this.question,
    this.answer,
  });

  @override
  bool operator ==(Object other) {
    return other is FAQ && other.question == question && other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}
