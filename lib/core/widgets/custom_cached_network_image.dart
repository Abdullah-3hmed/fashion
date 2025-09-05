import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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

  static final CacheManager _customCacheManager = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 150,
    ),
  );

  String _applyQuality(String url) {
    if (url.contains("res.cloudinary.com")) {
      return url.replaceFirst("/upload/", "/upload/q_80,f_auto,w_300/");
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final url =
        imageUrl.isEmpty
            ? "https://res.cloudinary.com/doz1vpcgr/image/upload/q_80,f_auto,w_300/v1756802120/ian-dooley-d1UPkiFd04A-unsplash_qy7eue.jpg"
            : _applyQuality(imageUrl);

    return CachedNetworkImage(
      cacheManager: _customCacheManager,
      imageUrl: url,
      width: width ?? double.infinity,
      height: height,
      fit: BoxFit.cover,
      memCacheWidth: 400,
      memCacheHeight: 400,
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
