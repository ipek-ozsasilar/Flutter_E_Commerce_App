part of '../../features/splash/splash_view.dart';


class SplashAnimationScreen extends StatefulWidget {
  const SplashAnimationScreen({super.key});

  @override
  State<SplashAnimationScreen> createState() => _SplashAnimationScreenState();
}

class _SplashAnimationScreenState extends State<SplashAnimationScreen>with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  final MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.center;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: DurationConstants.durationInstance.splashDuration,
      vsync: this,
    );

    // Zıplama hareketleri için TweenSequence
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: -400.0,
          end: -30.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -30.0,
          end: 10.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 10.0,
          end: -30.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.8,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -30.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.8,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -30.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.6,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -30.0,
          end: -10.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.6,
      ),
    ]).animate(_controller);

    // before start animation a little delay
    Future.delayed(DurationConstants.durationInstance.splashIconDelay , () {
      _controller.forward();
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: _mainAxisAlignment,
          children: [
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: Assets.icons.splashIcon.image(
                    width: IconSizeEnum.splashIconWidthAndHeight.value,
                    height: IconSizeEnum.splashIconWidthAndHeight.value,
                  ),
                );
              },
            ),
             Padding(
              padding: PaddingsConstants.splashIconOnlyLeftPadding,
              child: SplashAnimatedText(),
            ),
          ],
        );
  }
}