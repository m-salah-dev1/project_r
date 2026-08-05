import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/screen/welcom/onboarding_notifier.dart';
import 'package:project_r/screen/welcom/widget.dart';

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key});

  @override
  ConsumerState<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> {

  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexDotProvider);
    return Scaffold(
      appBar: AppBar(title: Text("" )),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:  PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    ref.read(indexDotProvider.notifier).change(value);
                  },
                  children: [
                    CustomPage(
                      co: _controller,
                      img: 'images/c1.png',
                      text: '',
                      subtitle: '',
                      index: index,
                      cont: context,
                    ),
                    CustomPage(
                      co: _controller,
                      img: 'images/c2.png',
                      subtitle: '',
                      index: index,
                      cont: context,
                    ),
                    CustomPage(
                      co: _controller,
                      img: 'images/c3.png',
                      subtitle: '',
                      index: index,
                      cont: context,
                    ),
                  ],
                ),
              
            ),
        
            SizedBox(height: 20),
            DotsIndicator( 
                dotsCount: 3,
                
                position: index.toDouble()),
        
        
          ],
        ),
      ),
    );
  }
}
