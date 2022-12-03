import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//!◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.
//?  SİZER paketini indirmelisin
// SAbit paddingler ayarlayarak stabil görüntü elde edebilirsain
//!◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.◣ ◤ ◥ ◬ ◭ ◮ ⫷ ⫸.

extension PaddingExtensionAll on BuildContext {
  double get dsukPadding => 4.h;
  double get normalPadding => 8.h;
  double get midyumPadding => 12.h;
  double get buyukPadding => 16.h;

  EdgeInsets get paddingLow => EdgeInsets.all(1.h); // 1
  EdgeInsets get paddingNormal => EdgeInsets.all(8.h);
  EdgeInsets get paddingMedium => EdgeInsets.all(12.h);
  EdgeInsets get paddingHigh => EdgeInsets.all(16.h);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical =>
      EdgeInsets.symmetric(vertical: dsukPadding);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalPadding);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: midyumPadding);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: buyukPadding);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: dsukPadding);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalPadding);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: midyumPadding);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: buyukPadding);
}
