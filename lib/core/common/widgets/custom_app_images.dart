import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppImages extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomAppImages({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  bool get isNetworkImage =>
      imagePath.startsWith('http') || imagePath.startsWith('https');

  @override
  Widget build(BuildContext context) {
    final extension = imagePath.split('.').last.toLowerCase();

    if (isNetworkImage) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image),
      );
    }

    switch (extension) {
      case 'svg':
        return SvgPicture.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
        );

      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'webp':
        return Image.asset(imagePath, width: width, height: height, fit: fit);

      default:
        return const Icon(Icons.image_not_supported);
    }
  }
}
