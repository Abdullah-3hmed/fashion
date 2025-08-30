import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          imageUrl.isEmpty
              ? "https://drive.google.com/uc?export=view&id=1oLoHL2ZYpm0KFwpRWmb2y-g6QGvTKbNi"
              : imageUrl,
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      fit: BoxFit.cover,
      errorWidget:
          (context, url, error) => Image.asset(
            AssetsManager.errorImage,
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            fit: BoxFit.cover,
          ),
    );
  }
}
