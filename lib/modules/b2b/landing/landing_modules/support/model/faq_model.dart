class FaqWrapper {
  String? title;
  List<FAQ>? faqs;

  FaqWrapper({this.title, this.faqs});

  factory FaqWrapper.fromJson(String title, List<Map<String, dynamic>> jsonList) {
    return FaqWrapper(title: title, faqs: jsonList.map((faq) => FAQ.fromJson(faq)).toList());
  }

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

  FAQ({this.question, this.answer});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(question: json['question'] ?? '', answer: json['answer'] ?? '');
  }

  @override
  bool operator ==(Object other) {
    return other is FAQ && other.question == question && other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}
