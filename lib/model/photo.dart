class Photo {
  /*

  photo 객체를 만들어서 활용하는 방법과, JSON to DART 사이트를 검색해서,
  변환하는 2가지 방법이 있다.

  class photo는 클래스를 만들어서 찍어내는 방법을 일컫는다.

  클래스 포토를 만들었다.

  JSON 문서는 MAP형태로 구성되어 있다.

  MAP은 키와 값의 구성 형태로 꾸려져 있다.

  키를 활용해서 값을 추출하는 과정이 중요하다.

  다시 말해, 찍어내는 것이 중요하다.

  공장에서 틀을 만들고 그 틀을 바꿔끼면서 인스턴스를

  찍어내는 것이 많은 JSON 데이터들을 처리하는 핵심 과정이다.

  factory는 틀을 바꾸는 역할을 한다.

  factory는 사용 방법이 정해져있다.

  쿡북에 나와있는 내용을 그대로 복붙하여 활용하면 된다.

   */

  final String previewURL;

  Photo({
    required this.previewURL,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      previewURL: json['previewURL'],
    );
  }
}
