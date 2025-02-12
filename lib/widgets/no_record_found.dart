import 'package:employee_app/shared/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoEmployFoundComponent extends StatelessWidget {
  const NoEmployFoundComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
   crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: SvgPicture.asset(AppImages.noRecord))
      ],
    );
  }
}