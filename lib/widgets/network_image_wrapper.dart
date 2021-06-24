import 'package:flutter/widgets.dart';

import 'network_image_wrapper/mobile_image.dart' if (dart.library.html) 'network_image_wrapper/web_image.dart';

/// Wrapper to display network image , it uses PlatformView while working at web and fallbacks to Image.network
/// That trick is required to assemble the build for mobile phones, reason is get rid off the "import 'dart:html'" statement
/// {@tool snippet}
///
/// Usage
///
/// ```dart
/// NetworkImageWrapper().build(...);
/// ```
/// {@end-tool}

abstract class NetworkImageWrapper {
  Widget build({required String? imageUrl, double? width, double? height});

  factory NetworkImageWrapper() => getImageWrapper();
}
