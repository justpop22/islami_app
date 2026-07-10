import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  double turn = 0.0;
  int counter = 30;
  int index = 0;

  final List<String> azkar = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله',
    'سبحان الله وبحمده',
    'سبحان الله العظيم',
    'صلي على النبي',
  ];

  @override
  void initState() {
    super.initState();
    _loadSebhaData();
  }


  Future<void> _loadSebhaData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      index = prefs.getInt('sebha_index') ?? 0;
      counter = prefs.getInt('sebha_counter') ?? 30;
      turn = prefs.getDouble('sebha_turn') ?? 0.0;
    });
  }

  Future<void> _saveSebhaData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sebha_index', index);
    await prefs.setInt('sebha_counter', counter);
    await prefs.setDouble('sebha_turn', turn);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double sebhaBodyHeight = size.height * .35;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/sebha_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/app_logo2.png'),
            const SizedBox(height: 16),
            const Text(
              'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 8,
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        turn = 0.0;
                        counter = 30;
                        index = 0;
                      });

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('sebha_index', 0);
                      await prefs.setInt('sebha_counter', 30);
                      await prefs.setDouble('sebha_turn', 0.0);
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                      size: 32,
                    ),
                    tooltip: 'Reset Tasbeeh',
                  ),
                ),

                Positioned(
                  top: 0,
                  left: size.width * 0.42,
                  child: Image.asset(
                    'assets/images/sebha_head.png',
                    width: size.width * .17,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: size.height * .08),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: turn,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          turn += 1 / 30;
                          counter--;
                          if (counter == 0) {
                            index++;
                            if (index >= azkar.length) index = 0;
                            counter = 30;
                          }
                        });
                        _saveSebhaData();
                      },
                      child: Image.asset(
                        'assets/images/sebha_body.png',
                        height: sebhaBodyHeight,
                      ),
                    ),
                  ),
                ),

                IgnorePointer(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * .08),
                    child: Container(
                      width: sebhaBodyHeight * 0.75,
                      height: sebhaBodyHeight * 0.75,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            azkar[index],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            counter.toString(),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
