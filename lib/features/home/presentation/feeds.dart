import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive.dart';
import '../../../ui_components/components/custom_drawer.dart';




class Feeds extends ConsumerStatefulWidget {
  Feeds({Key? key}) : super(key: key);

  @override
  ConsumerState<Feeds> createState() => _FeedsState();
}

class _FeedsState extends ConsumerState<Feeds> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      ) ? AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
      )
          : null,

      floatingActionButton: ScrollToTopButton(
        scrollController: scrollController,
      ),
      drawerEnableOpenDragGesture: true,
      drawer: const CustomDrawer(),
      body: Container(),
    );
  }

}

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset = scrollController.offset;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: scrollOffset > MediaQuery.of(context).size.height * 0.5
              ? FloatingActionButton(
            tooltip: "Scroll to top",
            child: const Icon(
              Icons.arrow_upward,
            ),
            onPressed: () async {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}



