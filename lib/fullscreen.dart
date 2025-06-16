import 'package:flutter/material.dart';

class FullScrenWalpaper extends StatefulWidget {
  final String imageurl;

  const FullScrenWalpaper({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<FullScrenWalpaper> createState() => _FullScrenWalpaperState();
}

class _FullScrenWalpaperState extends State<FullScrenWalpaper> {
  void loadmore() {
    // TODO: Implement your load more functionality here
    print('Load more pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(child: Image.network(widget.imageurl))),
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
                    "Set as Wallpaper",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
