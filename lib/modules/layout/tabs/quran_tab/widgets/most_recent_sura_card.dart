import 'package:flutter/material.dart';
import 'package:islami/core/extensions/extensions.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../models/sura.dart';

class MostRecentSuraCard extends StatelessWidget {
  final Sura sura;
  const MostRecentSuraCard({super.key,required this.sura});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sura.suraNameEn,style: context.appTextTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor),),
              SizedBox(height: 8,),
              Text(sura.suraNameAr,style: context.appTextTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor),),
              SizedBox(height: 8,),
              Text("${sura.ayaNumbers} verses",style: context.appTextTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primaryColor),),
            ],
          ),
          SizedBox(width: 5,),
          Image.asset("assets/images/recent.png"),
        ],
      ),
    );
  }
}
