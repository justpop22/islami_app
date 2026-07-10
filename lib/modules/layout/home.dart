import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/layout/tabs/hadeth_tab/hadeth_tab.dart';
import 'package:islami/modules/layout/tabs/quran_tab/quran_tab.dart';
import 'package:islami/modules/layout/tabs/radio_tab/radio_tab.dart';
import 'package:islami/modules/layout/tabs/sebha_tab/sebha_tab.dart';
import 'package:islami/modules/layout/tabs/time_tab/time_tab.dart';
import 'package:islami/provider/radio_manager_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String route = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> tabs = [
    QuranTab(),
    HadethTab(),
    SebhaTab(),
    ChangeNotifierProvider(create: (context) => RadioManagerProvider(),child: RadioTab()),
    TimeTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.secondaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
          },
        selectedItemColor: AppColors.white,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/quran.svg"),
            label: 'Quran',
            activeIcon: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(66),
              ),
              child: SvgPicture.asset("assets/icons/quran.svg", colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
            )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/hadeth.svg"),
            label: 'Hadeth',
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(66),
                ),
                child: SvgPicture.asset("assets/icons/hadeth.svg", colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/sebha.svg"),
            label: 'Sebha',
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(66),
                ),
                child: SvgPicture.asset("assets/icons/sebha.svg", colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              )
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/radio.svg"),
            label: 'Radio',
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(66),
                ),
                child: SvgPicture.asset("assets/icons/radio.svg", colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              )
          ),

/*
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/time.svg"),
            label: 'Time',
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(66),
                ),
                child: SvgPicture.asset("assets/icons/time.svg", colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              )
          ),
*/
        ],
      ),
      body: tabs[currentIndex],
    );
  }
}
