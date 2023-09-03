import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/app_theme/constants.dart';
import '../../../core/utils/responsive.dart';

class DataVisualizePage extends ConsumerStatefulWidget {
  const DataVisualizePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DataVisualizePage> createState() => _DataVisualizePageState();
}

class _DataVisualizePageState extends ConsumerState<DataVisualizePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(child: Lottie.asset('assets/lottie/under_const.json')),
    ));
  }
}
