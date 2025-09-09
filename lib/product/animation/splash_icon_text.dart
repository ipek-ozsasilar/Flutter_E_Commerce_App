part of '../../features/splash/splash_view.dart';

class SplashAnimationScreen extends StatefulWidget {
  const SplashAnimationScreen({super.key});

  @override
  State<SplashAnimationScreen> createState() => _SplashAnimationScreenState();
}

class _SplashAnimationScreenState extends State<SplashAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: DurationConstants.durationInstance.splashDuration,
      vsync: this,
    );

    _bounceAnimation = _createBounceAnimation();
  }

  Animation<double> _createBounceAnimation() {
    return TweenSequence([
      // İlk düşüş (baştan aşağı)
      _createBounceStep(-400.0, -30.0, 1.0, Curves.easeOut),
      // İlk zıplama yukarı
      _createBounceStep(-30.0, 10.0, 1.0, Curves.easeIn),
      // İkinci zıplama (daha küçük)
      _createBounceStep(10.0, -30.0, 0.8, Curves.easeOut),
      _createBounceStep(-30.0, 0.0, 0.8, Curves.easeIn),
      // Son micro zıplama
      _createBounceStep(0.0, -10.0, 0.6, Curves.easeOut),
      _createBounceStep(-10.0, 0.0, 0.6, Curves.easeIn),
    ]).animate(_controller);
  }

  TweenSequenceItem<double> _createBounceStep(
    double begin,
    double end,
    double weight,
    Curve curve,
  ) {
    return TweenSequenceItem(
      tween: Tween(begin: begin, end: end).chain(CurveTween(curve: curve)),
      weight: weight,
    );
  }

  void _startAnimation() {
    Future.delayed(DurationConstants.durationInstance.splashIconDelay, () {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildBounceIcon(), _buildAnimatedText()],
    );
  }

  Widget _buildBounceIcon() {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Assets.icons.splashIcon.image(
            width: IconSizeEnum.splashIconWidthAndHeight.value,
            height: IconSizeEnum.splashIconWidthAndHeight.value,
            semanticLabel: "splash_icon",
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return Padding(
      padding: PaddingsConstants.instance.splashIconOnlyLeftPadding,
      child: SplashAnimatedText(),
    );
  }
}
