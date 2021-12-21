import 'package:example/data/pixabay_api.dart';
import 'package:example/model/picture_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
     statefulwidget을 만들어서 ui구현할 준비한다.

     정보를 계속 받아와야 하기에, statefulwidget을 사용한다.

     scaffold를 사용해서 appbar와 바디를 만든다.

     텍스트 입력창과 검색 아이콘을 만들어 검색창을 구성한다.

     EXPANDED를 활용해서 이미지가 화면에 출력되도록 한다.

     ChILDREN에


     텍스트 입력창에 입력한 텍스트를 활용할 컨트롤러를 만든다.

     검색 아이콘을 클릭했을 때, 작동할 코드를 짜야 한다.

     그 코드는 onpressed에 들어가야 한다.

     'showresult'에 api 정보를 활용해, 상태 업데이트를 반영하는 코드를 담는다.

     구성된 'showresult'를 onpressed에 담는다.

     정보를 계속 받는다는 것은 setstate를 사용한다는 것이다.

     Pixabay_api를 생성자로 만든다.

     future를 활용해서 pixabay_api에서 받은 데이터를 담은 변수를 소환한다.

     setstate로 picture를 새로고침한다.





 */

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Picture> _pictures = [];

  final _api = PixabayApi();
  final _textEditingController = TextEditingController();

  //처음에 디폴트 값을 설정해주는 코드
  @override
  void initState() {
    super.initState();
    //한번 해야 하는 코드
    _showResult('iphone');
  }

  //메모리 해제. 컨트롤러를 써서 메모리를 묶어두면, 꼭 dispose를 써줘야 함.
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    List<Picture> pictures = await _api.fetchPhotos(query);
    setState(() {
      _pictures = pictures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _showResult(_textEditingController.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children:
                  //_pictures에 json 문서를 다트화한 데이터들이 담겨있다.
                  //  이걸, network 코드를 활용해, previewURL만 추출한다.
                  //내가 궁금했던건, 통신이 왜 안될까였는데, 이미 pictures에 데이터가
                  //담겨 있기 떄문에 그걸 활용하기만 하면 된다.
                  _pictures.map((e) => Image.network(e.previewURL)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
