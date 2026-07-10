import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/core/extensions/extensions.dart';

import '../../models/hadeth.dart';

class HadethDetails extends StatefulWidget {
  static const String route = "hadethDetails";
 const HadethDetails({super.key});

  @override
  State<HadethDetails> createState() => _HadethDetailsState();
}

class _HadethDetailsState extends State<HadethDetails> {
  Hadeth? hadeth;
  @override
  Widget build(BuildContext context) {
    hadeth??= ModalRoute.of(context)!.settings.arguments as Hadeth;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Hadeth ${hadeth?.hadethNum}',
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
                    hadeth?.title ?? "",
                    style: context.appTextTheme.bodyLarge!.copyWith(fontSize: 18),
                  ),
                  Image.asset("assets/images/sura_details_right.png"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                child: Text.rich(
                  TextSpan(
                    text: hadeth?.hadeth ?? "",
                    style: context.appTextTheme.labelLarge
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
