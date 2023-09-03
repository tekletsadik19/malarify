import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/animations/animation.dart';
import '../../core/utils/app_theme/constants.dart';
import '../../core/utils/custom_animation.dart';
import '../../core/utils/responsive.dart';
import '../../ui_components/widgets/button_option.dart';


class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin{
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<AnimationController> _controllers;
  @override
  void initState() {
    super.initState();
    _controllers = startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }
  @override
  void dispose() {
    pageViewController!.dispose();
    for (var controller in _controllers) {controller.dispose();}
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            PageView(
              controller: pageViewController ??= PageController(initialPage: 0),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: const AlignmentDirectional(0, 0),
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                40, 0, 40, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      child: FFButtonWidget(
                                        onPressed: (){
                                          context.go('/auth',extra: false);
                                        },
                                        text: 'Sign up',
                                        options: FFButtonOptions(
                                          width: ResponsiveWidget.isSmallScreen(context)
                                              ?screenSize.width/1.5
                                              :screenSize.width/3,
                                          height: 50,
                                          color: Theme.of(context).colorScheme.secondary,
                                          textStyle: AppTheme.bodyText1,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:BorderRadius.circular(50),
                                        ),
                                      ).animated([
                                        animationsMap[
                                        'buttonOnPageLoadAnimation1']!
                                      ]),

                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Already have account?',
                                          style:AppTheme.bodyText1
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(4, 0, 0, 0),
                                        child: TextButton(
                                          onPressed: ()=>context.push('/auth',extra: true),
                                          child: Text(
                                              'Log in',
                                              style:AppTheme.bodyText1
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).animated([
                                    animationsMap[
                                    'rowOnPageLoadAnimation1']!
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
