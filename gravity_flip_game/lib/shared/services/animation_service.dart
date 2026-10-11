import 'dart:async';

import 'package:flutter/material.dart';

class AnimationService {
  AnimationService();

  Future<void> waitForFrame() async {
    await WidgetsBinding.instance.endOfFrame;
  }

  Future<void> delay(Duration duration) async {
    await Future<void>.delayed(duration);
  }
}
