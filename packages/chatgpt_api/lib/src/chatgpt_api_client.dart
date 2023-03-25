import 'dart:convert';
import 'dart:io';

class ChatGptClient {
  String _apiKey;
  final String model = "gpt-3.5-turbo";
  final HttpClient _client;

  ChatGptClient({String? apiKey})
      : _client = HttpClient(),
        _apiKey = apiKey ?? '';

  set apiKey(String key) {
    _apiKey = key;
  }

  Future<String?> sendMessage(List<Map<String, String>> messages) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final converter = JsonUtf8Encoder();

    // send all current conversation to OpenAI
    final body = {
      'model': model,
      'messages': messages,
    };

    try {
      return await _client.postUrl(url).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        request.headers.set('Authorization', 'Bearer $_apiKey');
        request.add(converter.convert(body));
        return request.close();
      }).then((HttpClientResponse response) async {
        var retBody = await response.transform(utf8.decoder).join();
        if (response.statusCode == 200) {
          final data = json.decode(retBody);
          final completions = data['choices'] as List<dynamic>;
          if (completions.isNotEmpty) {
            final completion = completions[0];
            final content = completion['message']['content'] as String;
            // delete all the prefix '\n' in content
            final contentWithoutPrefix =
                content.replaceFirst(RegExp(r'^\n+'), '');
            return contentWithoutPrefix;
          }
        } else {
          // invalid api key
          // create a new dialog
          return "API KEY is Invalid";
        }
      });
    } on Exception catch (_) {
      return _.toString();
    }
  }
}
