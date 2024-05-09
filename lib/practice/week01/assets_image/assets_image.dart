import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestAssetsAndImages extends StatelessWidget {
  const TestAssetsAndImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets and Images'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/image.png',
              width: 200,
              height: 200,
            ),
            Image.network(
              'https://th.bing.com/th/id/OIP.vNpR-4DYMRCXEEpfrAzLXwHaE8?rs=1&pid=ImgDetMain',
              width: 200,
              height: 200,
            ),
            CachedNetworkImage(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.vNpR-4DYMRCXEEpfrAzLXwHaE8?rs=1&pid=ImgDetMain",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 200,
              height: 200,
            ),
            SvgPicture.asset(
              'assets/images/image2.svg',
              semanticsLabel: 'test image',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
