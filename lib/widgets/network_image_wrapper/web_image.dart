import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../network_image_wrapper.dart';

class WebImage implements NetworkImageWrapper {
  @override
  Widget build({String? imageUrl, double? width, double? height}) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl!,
      (int viewId) => ImageElement(src: imageUrl),
    );
    return SizedBox(
      width: width,
      height: height,
      child: IgnorePointer(
        child: HtmlElementView(
          viewType: imageUrl!,
        ),
      ),
    );
  }
}

NetworkImageWrapper getImageWrapper() => WebImage();
