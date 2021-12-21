import 'dart:convert';

import 'package:example/model/picture_result.dart';
import 'package:http/http.dart' as http;

/* data 폴더에 담겨 있는 'pixabayApi'

  이 다트 파일은, 2가지 역할을 수행한다.

1.첫 번째는 API에서 JSON 문서를 송신하는 역할이고,

2.두 번째는 송신 받은 JSON 문서에 담긴 내용 정보를 DART화하는 역할이다.

  첫 번째 역할은, FUTURE와 AWAIT 코드를 활용한다.

  FUTURE 코드를 사용하려면 HTTP를 IMPORT 해야한다.

  AWAIT는 FUTURE와 꼭 함께 쓰이니 주의해서 사용하자.

  AWAIT는 API로부터 딜레이되는 정보를 계속 가지고 올 때(get을 사용), 사용한다.

  두 번째 역할은, model 폴더에 있는 JSON TO DART 껍데기를 활용해 JSON 문서를 DART화한다.

  JSON 문서는 MAP 형태로 '키'와 '값'을 가진다.

  이런 JSON 문서에서 필요한 정보의 '키'를 JSONDECODE 함수를 이용해서 변수에 저장한다.

  이렇게 추출된 정보를 담은 변수를 껍데기에 넣는다.

  그러면 MAP형태의 내용이 MAP으로 묶여서 LIST 형태로 저장된다.


*/
class pixabayApi {
  Future<List<Picture>> fetchPhotos(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=17828481-17c071c7f8eadf406822fada3&q=$query&image_type=photo&per_page=100'));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['hits'];
      return jsonList.map((e) => Picture.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
