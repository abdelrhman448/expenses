
// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as my_path;


// ignore: must_be_immutable
class CustomAssetImage extends StatelessWidget {
  final String image;
  double? height;
  double? width;
  Color? color;
  BoxFit fit;
  CustomAssetImage({Key? key,required this.image,this.height,this.width,this.fit=BoxFit.contain,this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: my_path.extension(image)==".svg",
          child: SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit,
            // ignore: deprecated_member_use
            color: color,
          ),
        ),
        Visibility(
          visible: my_path.extension(image)!=".svg",
          child: Image(
            width: width,
            height: height,
            image: AssetImage(image),
            fit: fit,
            color: color,
          ),
        ),
      ],
    );

  }
}
