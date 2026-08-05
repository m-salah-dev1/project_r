import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexDotProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void change(int value) {
    state = value;
  }
}



//! this is provider
final indexDotProvider = NotifierProvider<IndexDotProvider, int>(
  IndexDotProvider.new,
);
