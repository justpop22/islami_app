import 'package:flutter/material.dart';
import 'package:islami/core/extensions/extensions.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../models/hadeth.dart';

class HadethCard extends StatelessWidget {
  final Hadeth hadeth;
  const HadethCard({super.key, required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/hadeth_card2.png"),
          fit: BoxFit.fill,
          opacity: 0.9
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28,horizontal: 40),
                child: Text(
                  hadeth.title,
                  style: context.appTextTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                hadeth.hadeth,
                textDirection: TextDirection.rtl,
                style: context.appTextTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryColor,
                  height: 1.7,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin hadethList {
}
