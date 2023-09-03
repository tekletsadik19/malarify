import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malarify/features/auth/presentation/signin/signin.dart';
import 'package:malarify/features/auth/presentation/signup/controller/signup_controller.dart';
import 'package:malarify/features/auth/presentation/signup/signup.dart';

import '../../../core/animations/animation.dart';
import '../../../core/utils/app_theme/constants.dart';
import '../../../core/utils/custom_animation.dart';
import '../../../core/utils/progress_indicators.dart';
import '../../../core/utils/responsive.dart';
import '../../../ui_components/components/slide_fade_switcher.dart';



const _kTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Color(0xFF9A9A9A),
);

class AuthViewPage extends ConsumerStatefulWidget {
  bool? showSignIn;
  AuthViewPage({Key? key,this.showSignIn = false}) : super(key: key);
  static String routeName = 'auth';
  @override
  ConsumerState<AuthViewPage> createState() => _AuthViewStateState();
}

class _AuthViewStateState extends ConsumerState<AuthViewPage> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  @override
  void initState() {
    _controllers = startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    super.initState();
  }
  @override
  void dispose() {
    for (var controller in _controllers) {controller.dispose();}
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final signupController = ref.read(signupProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children: [
            signupController.loading?linearProgress(context):Container(),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Malarify',
                  style: AppTheme.title1,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 200, 16, 0),
                  child: SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context)?screenSize.width/1.3:screenSize.width/2.8,
                    child: SlideFadeSwitcher(
                      child: widget.showSignIn!?Builder(
                        builder: (BuildContext context) {
                          return SignIn();
                        },
                      ):SignUp(),
                    ),
                  )
              ),
            ),
            Positioned(
              left: 0,right: 0,bottom: 30,
              child: GestureDetector(
                onTap: (){
                  setState((){
                    widget.showSignIn = !widget.showSignIn!;
                  });
                },
                child:  Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SlideFadeSwitcher(
                    child: widget.showSignIn!?
                    const Text(
                        "don't have account? sign up",
                        key: ValueKey('sign in'),
                        style:_kTextStyle
                    ):
                    const Text(
                      "already have account? sign in",
                      key: ValueKey('sign up'),
                      style: _kTextStyle,
                    ),
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}
