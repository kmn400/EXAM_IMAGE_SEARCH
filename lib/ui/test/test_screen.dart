import 'dart:convert';

import 'package:example/model/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future<List<Album>> fetchAlbums() async {
    // await [Future가 리턴되는 코드]
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=17828481-17c071c7f8eadf406822fada3&q=iphone&image_type=photo'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.listToAlbums(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Sample'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('Album들 가져오기'),
          ),
          FutureBuilder<List<Album>>(
            future: fetchAlbums(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return const Center(child: Text('네트워크 에러!!!'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // 데이터가 없다면
              if (!snapshot.hasData) {
                return const Center(child: Text('데이터가 없습니다'));
              }

              // 데이터가 여기에서는 무조건 있는 상황
              final List<Album> albums = snapshot.data!;

              return _buildAlbums(albums);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlbums(List<Album> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(albums[index].title),
          );
        },
      ),
    );
    // return Expanded(
    //   child: ListView(
    //     children: albums.map((e) => ListTile(title: Text(e.title))).toList(),
    //   ),
    // );
  }

  Widget _buildBody(Album album) {
    return Text(
      '${album.id} : ${album.toString()}',
      style: const TextStyle(fontSize: 30),
    );
  }
}
