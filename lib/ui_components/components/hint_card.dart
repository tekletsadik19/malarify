import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malarify/core/animations/animation.dart';

import '../../core/utils/app_theme/constants.dart';
import '../../core/utils/custom_animation.dart';
import '../../core/utils/responsive.dart';
import '../widgets/button_option.dart';


class HintCard extends StatelessWidget {
  const HintCard({Key? key,
    required this.title,
    this.icon,
    this.onPressed
  })
      : super(key: key);
  final String title;
  final IconData? icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FFButtonWidget(
        onPressed:onPressed??(){},
        icon:  Icon(icon),
        text: title,
        showLoadingIndicator: true,
        options: FFButtonOptions(
          width: ResponsiveWidget.isSmallScreen(context)
              ?screenSize.width/1.5
              :screenSize.width/3,
          height: 150,

          color: Theme.of(context).colorScheme.secondary,
          textStyle: AppTheme.bodyText1,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
        ),
      ).animated([
        animationsMap[
        'buttonOnPageLoadAnimation1']!
      ]),
    );
  }
}
