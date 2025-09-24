import 'package:flutter/material.dart';

abstract class AdsService {
  Future<void> init();
  Widget banner();
}
