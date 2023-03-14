import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({
    required this.url,
    Key? key,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
      ),
      body: InteractiveViewer(
        child: SafeArea(
          child: Center(
            child: Hero(
              tag: url,
              child: Image.network(url),
            ),
          ),
        ),
      ),
    );
  }
}
