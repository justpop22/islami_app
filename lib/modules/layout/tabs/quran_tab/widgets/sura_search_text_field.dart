import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/extensions/extensions.dart';

import '../../../../../core/theme/app_colors.dart';

class SuraSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  const SuraSearchTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor:  AppColors.white,
      style: TextStyle(color: AppColors.white,fontFamily: "jana"),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1,color: AppColors.secondaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1,color: AppColors.secondaryColor)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1,color: AppColors.secondaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1,color: AppColors.secondaryColor)
          ),
          filled: true,
          fillColor: AppColors.primaryColor.withValues(alpha: 0.5),
          hintText: "Sura Name",
          hintStyle: context.appTextTheme.bodyMedium,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset("assets/icons/quran.svg",
              colorFilter: ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),),
          )
      ),

    );
  }
}
