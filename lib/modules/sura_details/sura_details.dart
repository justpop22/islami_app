import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/extensions/extensions.dart';

import '../../models/sura.dart';

class SuraDetails extends StatefulWidget {
  static const String route = "sura Details";
  SuraDetails({super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  Sura? sura;

  String suraDetails = '';
  List<String> ayat = [];

  @override
  Widget build(BuildContext context) {
    sura ??= ModalRoute.of(context)!.settings.arguments as Sura;
    if (suraDetails.isEmpty) {
      readSura(sura?.id ?? 0);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          sura?.suraNameEn ?? "",
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sura_details_background.png"),opacity: 0.3,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/sura_details_left.png"),
                  Text(
                    sura?.suraNameAr ?? "",
                    style: context.appTextTheme.bodyLarge,
                  ),
                  Image.asset("assets/images/sura_details_right.png"),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: ayat.map((aya) {
                    int index = ayat.indexOf(aya);
                    return TextSpan(
                      text: aya,
                      children: [TextSpan(text: " [${index + 1}] ",style: context.appTextTheme.labelLarge,)],

                    );
                  }).toList(),
                  style: context.appTextTheme.labelLarge!.copyWith(
                    color: context.appTheme.colorScheme.secondary,
                    height: 2
                  )
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void readSura(int id) async {
    suraDetails = await rootBundle.loadString("assets/suras/$id.txt");
    ayat = suraDetails.trim().split('\n');
    setState(() {});
  }
}
