import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/app_theme/constants.dart';
import '../../../core/utils/responsive.dart';


class DetectMalariaPage extends ConsumerStatefulWidget {
  const DetectMalariaPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DetectMalariaPage> createState() => _DetectMalariaPageState();
}

class _DetectMalariaPageState extends ConsumerState<DetectMalariaPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(child: Lottie.asset('assets/lottie/under_const.json')),
      ),
    );
  }
}

