import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walpaper_app/fullscreen.dart';

class WallpaperWidget extends StatefulWidget {
  const WallpaperWidget({super.key});

  @override
  State<WallpaperWidget> createState() => _WallpaperWidgetState();
}

class _WallpaperWidgetState extends State<WallpaperWidget> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  Future<void> fetchapi() async {
    await http
        .get(
          Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
          headers: {
            'Authorization':
                'kLzTzRezd2giUHEHv1UUyYrchR1Gj6ScNFqPQlbhCcvQQBNZUdkpkoCS',
          },
        )
        .then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images = result['photos'];
          });
          print(images[0]);
        });
  }

  Future<void> loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    final response = await http
        .get(
          Uri.parse(url),
          headers: {
            'Authorization':
                'kLzTzRezd2giUHEHv1UUyYrchR1Gj6ScNFqPQlbhCcvQQBNZUdkpkoCS',
          },
        )
        .then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['photos']);
          });
        });
    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      setState(() {
        images.addAll(result['photos']);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2, //cap for vertical
                  mainAxisSpacing: 2, //cap for horizontal
                  crossAxisCount: 3, //boxcount
                  childAspectRatio: 2 / 3, //size
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScrenWalpaper(
                            imageurl: images[index]['src']['large2x'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: const Color.fromARGB(255, 25, 25, 26),
              child: Center(
                child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
