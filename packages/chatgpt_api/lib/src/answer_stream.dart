import 'dart:async';

class AnswerStream {
  String answer = '';
  StreamController answerController = StreamController<String>.broadcast();
  Stream<String> get answerStream =>
      answerController.stream.transform<String>(counterTranformer);

  var counterTranformer =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    // change data before emit
    sink.add(data);
  });

  void clearAnswer() {
    answer = '';
  }

  void addWord(String world) {
    answer += world;
    answerController.sink.add(answer);
  }

  void addError(String error) {
    answerController.sink.add(error);
  }

  void closeStream() {
    answerController.close();
  }

  void dispose() {
    answerController.close();
  }
}
