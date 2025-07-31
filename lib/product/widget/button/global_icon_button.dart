import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/provider/login_provider.dart';
import 'package:flutter_e_commerce_app/product/constants/duration_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalIconButton extends ConsumerStatefulWidget {
   GlobalIconButton({super.key, required this.icon, required this.color});
  final AnimatedIconData icon;
  final Color color;

  @override
  ConsumerState<GlobalIconButton> createState() => _GlobalIconButtonState();
}

class _GlobalIconButtonState extends ConsumerState<GlobalIconButton> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: DurationConstants.durationInstance.onboardingPageTransitionDuration, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {
            if (widget.icon == AnimatedIcons.pause_play) {
              ref.read(loginProvider.notifier).changeObscureText();
              if (ref.watch(loginProvider).isObscureText) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            }else{
              //clear text
            }
            
            
          },
          child: AnimatedIcon(icon: widget.icon, progress: _controller),
        );
  }
}