import 'package:college_saathi_final/common/widgets/loaders/animation_loader.dart';
import 'package:college_saathi_final/utils/constants/colors.dart';
import 'package:college_saathi_final/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => _FullScreenLoaderDialog(
        text: text,
        animation: animation,
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

class _FullScreenLoaderDialog extends StatelessWidget {
  final String text;
  final String animation;

  const _FullScreenLoaderDialog({
    required this.text,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

