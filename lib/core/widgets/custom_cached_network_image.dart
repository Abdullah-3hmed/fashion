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

  String _applyQuality(String url) {
    if (url.contains("res.cloudinary.com")) {
      return url.replaceFirst("/upload/", "/upload/q_20/");
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final finalUrl =
        imageUrl.isEmpty
            ? "https://res.cloudinary.com/doz1vpcgr/image/upload/q_20,f_auto/v1756802120/ian-dooley-d1UPkiFd04A-unsplash_qy7eue.jpg"
            : _applyQuality(imageUrl);

    return CachedNetworkImage(
      imageUrl: finalUrl,
      width: width ?? double.infinity,
      height: height,
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
