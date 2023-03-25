import 'package:flutter_test/flutter_test.dart';

import 'package:chatgpt_api/chatgpt_api.dart';

void main() {
  test('test api', () async {
    List<Map<String, String>> list = List.empty();
    final calculator = ChatGptClient(apiKey: 'key');
    expect(await calculator.sendMessage(list), 'API KEY is Invalid');
  });
}
