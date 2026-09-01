import 'package:flutter/foundation.dart';

// Holds the currently selected side-menu index across the app.
// 0 = Homepage, 1 = Discover, 2 = My Order, 3 = Profile
final ValueNotifier<int> sideMenuIndex = ValueNotifier<int>(0);
