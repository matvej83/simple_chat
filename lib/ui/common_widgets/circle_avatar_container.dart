import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarContainer extends StatelessWidget {
  const CircleAvatarContainer({
    Key? key,
    required this.imageUrl,
    required this.containerSize,
    this.borderWidth = 1.0,
    this.borderColor,
    this.maxCacheImageSize = 200,
    this.defaultAssetImage,
    this.defaultIconColor = Colors.white,
    this.errorWidget,
  }) : super(key: key);

  final String imageUrl;
  final double containerSize;
  final double borderWidth;
  final Color? borderColor;
  final int maxCacheImageSize;
  final String? defaultAssetImage;
  final Color? defaultIconColor;
  final Widget? errorWidget;

  Widget _getDefaultAssetImage(String defaultAssetImage) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(containerSize / 2),
        ),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        image: DecorationImage(
          image: AssetImage(defaultAssetImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _getErrorWidget() {
    if (errorWidget != null) {
      return errorWidget!;
    }
    if (defaultAssetImage != null) {
      return _getDefaultAssetImage(defaultAssetImage!);
    }
    return Icon(
      Icons.account_circle_rounded,
      size: containerSize,
      color: defaultIconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      memCacheHeight: maxCacheImageSize,
      memCacheWidth: maxCacheImageSize,
      maxHeightDiskCache: maxCacheImageSize,
      maxWidthDiskCache: maxCacheImageSize,
      imageBuilder: (context, imageProvider) => Container(
        height: containerSize,
        width: containerSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(containerSize / 2),
          ),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: containerSize,
        height: containerSize,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => _getErrorWidget(),
    );
  }
}
