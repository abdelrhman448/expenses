import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;
import 'custom_widget/loading_animation_widget.dart';

class NetworkImageComponent extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? placeholderColor;
  final Widget? customPlaceholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const NetworkImageComponent({
    super.key,
    this.imageUrl,
     this.width,
     this.height,
    this.fit = BoxFit.cover,
    this.placeholderColor = Colors.grey,
    this.customPlaceholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // If imageUrl is null or empty, show placeholder
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildEmptyWidget(context);
    }

    // Check if image is SVG
    final extension = path.extension(imageUrl!).toLowerCase();
    final isSvg = extension == '.svg';

    // Create ClipRRect for border radius if needed
    Widget imageWidget = isSvg
        ? _buildSvgImage(context)
        : _buildCachedNetworkImage(context);

    // Apply border radius if specified
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildEmptyWidget(BuildContext context) {
    if (customPlaceholder != null) {
      return customPlaceholder!;
    }
    return Container(
      width: width,
      height: height,
      color: placeholderColor,
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: 30.h,
        ),
      ),
    );
  }
  Widget _buildPlaceHolderWidget(BuildContext context) {
    
    return  Center(
      child:AdaptiveLoadingAnimationWidget(
        size: 2.h,
      ),
    );;
  }

  Widget _buildSvgImage(context) {
    return SvgPicture.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (context) => _buildEmptyWidget(context),
    );
  }

  Widget _buildCachedNetworkImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildPlaceHolderWidget(context),
      errorWidget: (context, url, error) => errorWidget ?? _buildEmptyWidget(context),
    );
  }
}