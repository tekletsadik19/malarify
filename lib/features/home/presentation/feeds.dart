import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:malarify/core/utils/app_theme/constants.dart';
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
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Generated code for this Row Widget...
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Hi,',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF39CBC3), fontSize: 19),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(
                                  '',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Color(0xFF39CBC3), fontSize: 19),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 6, 0, 0),
                            child: Text(
                              "Let's Fight Malaria Togather",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.deepOrange, fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.darkAccent,
                            ),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                2, 0, 2, 0),
                            child: TextFormField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search for malaria strategies',
                                hintStyle: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF39CBC3), fontSize: 19),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: const FaIcon(
                            FontAwesomeIcons.slidersH,
                            color: Color(0xFF828282),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  CustomCard(
                    onTap: () => context.push('/edu-gen'),
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 100,
                          child:
                              Lottie.asset('assets/lottie/generate_edu.json'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 15, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Generate Edu Content',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.deepOrange, fontSize: 19),
                                  ),
                                ),
                                Text(
                                  'Malaria Related Educational Content Generation in Multiple Formats',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.blue, fontSize: 14),
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
                          child:
                              Lottie.asset('assets/lottie/visualize_data.json'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 15, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Visualize Malaria Data',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.deepOrange, fontSize: 19),
                                  ),
                                ),
                                Text(
                                  'Deep AI Malaria Detection features',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.blue, fontSize: 14),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 15, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Malaria Detection',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.deepOrange, fontSize: 19),
                                  ),
                                ),
                                Text(
                                  'Malaria Related Educational Content Generation in Multiple Formats',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.blue, fontSize: 14),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
