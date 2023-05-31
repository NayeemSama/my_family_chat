import 'package:flutter/cupertino.dart';

// extension Dimensions on num {
//   /// Calculates the height depending on the device's screen size
//   ///
//   /// Eg: 20.h -> will take 20% of the screen's height
//   double get h => this * SCREEN_HEIGHT.height / 100;
//
//   /// Calculates the width depending on the device's screen size
//   ///
//   /// Eg: 20.w -> will take 20% of the screen's width
//   double get w => this * SizerUtil.width / 100;
//
//   /// Calculates the sp (Scalable Pixel) depending on the device's screen size
//   double get sp => this * (SizerUtil.width / 3) / 100;
// }

class Dimensions {
  double h = 0.0;
  double w = 0.0;

  Dimensions._create(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    // Do most of your initialization here, that's what a constructor is for
    //...
  }

  /// Public factory
  static Dimensions create(BuildContext context) {
    // Call the private constructor
    var component = Dimensions._create(context);

    // Do initialization that requires async
    //await component._complexAsyncInit();

    // Return the fully initialized object
    return component;
  }
}
