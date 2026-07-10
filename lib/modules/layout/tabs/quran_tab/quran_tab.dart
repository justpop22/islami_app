import 'package:flutter/material.dart';
import 'package:islami/core/app_const/app_const.dart';
import 'package:islami/core/cashing/cashing_keys.dart';
import 'package:islami/core/extensions/extensions.dart';
import 'package:islami/core/init_app.dart';
import 'package:islami/models/sura.dart';
import 'package:islami/modules/layout/tabs/quran_tab/widgets/most_recent_sura_card.dart';
import 'package:islami/modules/layout/tabs/quran_tab/widgets/sura_card.dart';
import 'package:islami/modules/layout/tabs/quran_tab/widgets/sura_search_text_field.dart';
import 'package:islami/modules/sura_details/sura_details.dart';

class QuranTab extends StatefulWidget {
  QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  TextEditingController search = TextEditingController();
  List<Sura> quran = [];
  List<Sura> searched = [];
  List<int> recentSursIndex = [];
  @override
  void initState() {
    super.initState();
    readQuran();
    search.addListener(() {
      if (search.text.isEmpty) {
        searched = quran;
      } else {
        searched = quran
            .where(
              (sura) =>
                  sura.suraNameEn.trim().toLowerCase().contains(
                    search.text.trim().toLowerCase(),
                  ) ||
                  sura.suraNameAr.trim().contains(search.text.trim()),
            )
            .toList();
      }
      setState(() {});
    });
    getRecent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/quran_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset("assets/images/app_logo2.png")),
            SizedBox(height: 20),
            SuraSearchTextField(controller: search),
            SizedBox(height: 20),
            if (recentSursIndex.isNotEmpty) ...[
              Text("Most Recently", style: context.appTextTheme.bodyMedium),
              SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SuraDetails.route,
                        arguments: quran[recentSursIndex[index]],
                      );
                    },
                    child: MostRecentSuraCard(
                      sura: quran[recentSursIndex[index]],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: recentSursIndex.length,
                ),
              ),
              SizedBox(height: 10),
            ],
            Text("Suras List", style: context.appTextTheme.bodyMedium),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: searched.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    if (!recentSursIndex.contains(index)) {
                      recentSursIndex.add(index);
                      var stringIndexList = recentSursIndex
                          .map((index) => index.toString())
                          .toList();
                      InitApp.sharedPreferences.setStringList(
                        CashingKeys.getRecent,
                        stringIndexList,
                      );
                    }
                    setState(() {});
                    Navigator.pushNamed(
                      context,
                      SuraDetails.route,
                      arguments: searched[index],
                    );
                  },
                  child: SuraCard(sura: searched[index]),
                ),
                separatorBuilder: (_, index) => Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    search.dispose();
  }

  void readQuran() {
    for (int i = 0; i < arabicAuranSuras.length; i++) {
      quran.add(
        Sura(
          id: i + 1,
          suraNameAr: arabicAuranSuras[i],
          suraNameEn: englishQuranSurahs[i],
          ayaNumbers: AyaNumber[i],
        ),
      );
    }
    searched = quran;
  }

  getRecent() async {
    recentSursIndex =
        InitApp.sharedPreferences
            .getStringList(CashingKeys.getRecent)
            ?.map((index) => int.parse(index))
            .toList() ??
        [];
  }
}
