import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final networkSrcReg = RegExp("^http");
final localSrcReg = RegExp("^asset");
final fileSrcReg = RegExp("^/private");
final simulatorSrcReg = RegExp('^/Users');

class CommonImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CommonImage(
      {super.key, required this.src, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    if (networkSrcReg.hasMatch(src)) {
      return CachedNetworkImage(
        imageUrl: src,
        width: width,
        height: height,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    if (localSrcReg.hasMatch(src)) {
      return Image.asset(src, fit: fit, width: width, height: height);
    }

    if(fileSrcReg.hasMatch(src) || simulatorSrcReg.hasMatch(src)) {
      return Image.file(File(src), fit: fit, width: width, height: height);
    }

    return Container();
  }
}
