import 'package:bloc/bloc.dart';

class SendButtonCubit extends Cubit<bool> {
  SendButtonCubit() : super(false);

  void textChange(String content) {
    if (content.isEmpty) {
      return emit(false);
    } else {
      return emit(true);
    }
  }
}
