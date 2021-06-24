import 'package:flutter/widgets.dart';

import '../network_image_wrapper.dart';

class MobileImage implements NetworkImageWrapper {
  @override
  Widget build({String? imageUrl, double? width, double? height}) {
    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: (width != null && height != null) ? BoxFit.contain : null,
    );
  }
}

NetworkImageWrapper getImageWrapper() => MobileImage();
