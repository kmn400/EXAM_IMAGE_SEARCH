import 'dart:convert';

import 'package:example/model/photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  /*

  1. JSON 요청 -> future 활용
     Future 함수를 통해, 픽사베이 API를 활용해서,
     JSON 문서를 그대로 화면에 출력한다.

     http 통신을 활용해 response 변수에 api 주소를 활용해,
     JSON 문서를 갖고 온다.

     jsonDecode를 활용해, index값에 키를 넣어 값을 불러온다.
     그렇게 불러온 값을 list에 담는다. 바로 이 list, jsonList가 json문서 BODY다.

      다만, async를 활용해야 하기에, await를 넣어준다.
     async로 추출되는 값은 지연이 되기 때문에 꼭 'await'를 넣어줘야 한다.

     이 json문서에서 클래스를 활용해, 필요한 값을 추출하는 과정이 바로 2번이다.

  2. 필요한 데이터만 클래스로 바꾸기. -> PHOTO 클래스
     photo 클래스를 새롭게 만든다.
     이유는 JSON 문서 중 필요한 부분을 뽑아내기 위해서다.
     FACTORY를 활용해 JSON의 맵 형식(키, 값)을 이용한다.
     FACTORY는 사용 방법이 정해져있기 때문에,
     쿡북을 참고하면 된다.

     FACTORY에서 추출한 JSON 값은 맵 형태로 추출된다.

     이를 다시 리스트로 만들어서 빈 리스트 안에 넣어준다.

     setState를 활용해, jsonList를 새로고침해준다.

  3. 받은 URL 활용해서 화면 구현.
     Scaffold를 활용해 title과 body를 구성한다.
     버튼을 만들어 클릭하면 이미지가 화면에 채워지는 것을 상상한다.

     PHOTOS에 담긴 리스트 length만큼 화면에 이미지가 출력될 수 있게 하는
     LISTVIEW를 활용한다.
     listview는 itemcount와 itembuilder가 들어간다.
     리턴으로 listtile을 사용해서 PHOTOS에 담겨 있는 index값을 활용해
     previewURL을 network해 이미지화한다.

   */

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photo> photos = [];

  Future<void> fetchPhotos() async {
    http.Response response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=17828481-17c071c7f8eadf406822fada3&q=lion&image_type=photo'));

    List jsonList = jsonDecode(response.body)['hits'];

    setState(() {
      photos = jsonList.map((e) => Photo.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('API test'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  fetchPhotos();
                },
                child: Text('이미지 가져오기')),
            Expanded(
              child: ListView.builder(
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(photos[index].previewURL),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
