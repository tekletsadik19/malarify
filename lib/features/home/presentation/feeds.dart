import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:malarify/core/animations/animation.dart';

import '../../../core/utils/app_theme/constants.dart';
import '../../../core/utils/custom_animation.dart';
import '../../../core/utils/responsive.dart';
import '../../../ui_components/components/custom_card.dart';
import '../../../ui_components/components/custom_drawer.dart';

class Feeds extends ConsumerStatefulWidget {
  Feeds({Key? key}) : super(key: key);

  @override
  ConsumerState<Feeds> createState() => _FeedsState();
}

class _FeedsState extends ConsumerState<Feeds> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      )
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
              centerTitle: false,
              elevation: 0,
            )
          : null,
      drawerEnableOpenDragGesture: true,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          CustomCard(
            onTap: ()=>context.push('/edu-gen'),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 120,
                  width: 100,
                  child: Lottie.asset('assets/lottie/generate_edu.json'),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Generate Edu Content',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                            textStyle:
                                const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19
                                ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomCard(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 120,
                  width: 100,
                  child: Lottie.asset('assets/lottie/visualize_data.json'),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visualize Malaria Data',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                            textStyle:
                                const TextStyle(color: Colors.deepOrange,fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomCard(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 120,
                  width: 100,
                  child: Lottie.asset('assets/lottie/medicall.json'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Malaria Detection',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(color: Colors.deepOrange,fontSize: 19),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
