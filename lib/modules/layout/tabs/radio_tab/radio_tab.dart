import 'package:flutter/material.dart';
import 'package:islami/modules/layout/tabs/radio_tab/widgets/radio_reciter_widget.dart';

import '../../../../Api/api_manager.dart';
import '../../../../models/radio_reciters_model.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  int selectedIndex = 0;
  late Future<RadioRecitersModel> _apiFuture;

  @override
  void initState() {
    super.initState();
    _apiFuture = ApiManager.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/app_logo2.png',
              height: 125,
            ),
            const SizedBox(height: 12),
      
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E).withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  // Radio Tab Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedIndex == 0) return;
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? const Color(0xFFD9B982)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Text(
                          "Radio",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == 0 ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
      
                  // Reciters Tab Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedIndex == 1) return;
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? const Color(0xFFD9B982)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Text(
                          "Reciters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == 1 ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
      
            // Data Stream Section
            Expanded(
              child: FutureBuilder<RadioRecitersModel>(
                future: _apiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white,));
                  }

                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text("Please check your Internet connection",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 22,
                          ),),
                        ),
                        Image.asset("assets/images/crisis.png"),
                      ],
                    );
                  }

                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text("No Data",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 22,
                          ),),
                        ),
                        Image.asset("assets/images/crisis.png"),
                      ],
                    );
                  }
      
                  final data = snapshot.data!;
                  final itemCount = selectedIndex == 0
                      ? (data.radioResponseModel.radios?.length ?? 0)
                      : (data.recitersResponseModel.reciters?.length ?? 0);

                  if (itemCount == 0) {
                    return const Center(child: Text("No Items Available"));
                  }
      
                  return ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (selectedIndex == 0) {
                        // --- RADIO MODE ---
                        final radios = data.radioResponseModel.radios;
                        if (radios == null || index >= radios.length) {
                          return const SizedBox.shrink();
                        }
      
                        final radio = radios[index];
                        final url = radio.url ?? "";
      
                        return RadioReciterWidget(
                          sheikhName: radio.name ?? "Unknown Radio",
                          audioUrl: url,
                        );
                      } else {
                        // --- RECITERS MODE ---
                        final reciters = data.recitersResponseModel.reciters;
                        if (reciters == null || index >= reciters.length) {
                          return const SizedBox.shrink();
                        }
      
                        final reciter = reciters[index];
                        String audioUrl = "";
      
                        if (reciter.moshaf != null && reciter.moshaf!.isNotEmpty) {
                          final moshaf = reciter.moshaf![0];
                          String server = (moshaf.server ?? "").trim();
                          final surahListString = moshaf.surahList ?? "";
      
                          if (server.isNotEmpty && surahListString.isNotEmpty) {
                            server = server.replaceAll('\\', '/');
      
                            if (server.startsWith("//")) {
                              server = "https:$server";
                            }
                            else if (server.startsWith("http://")) {
                              server = server.replaceFirst("http://", "https://");
                            }
                            else if (!server.startsWith("https://")) {
                              server = "https://$server";
                            }
      
                            if (!server.endsWith("/")) {
                              server = "$server/";
                            }
      
                            List<String> availableSurahs = surahListString.split(',');
                            if (availableSurahs.isNotEmpty) {
                              String targetSurah = availableSurahs[0].replaceAll(RegExp(r'\s+'), '');
                              String paddedSurahNumber = targetSurah.padLeft(3, '0');
      
                              final rawUrl = "$server$paddedSurahNumber.mp3";
                              final parsedUri = Uri.tryParse(rawUrl);
      
                              if (parsedUri != null) {
                                audioUrl = parsedUri.toString();
                              }
                            }
                          }
                        }
      
                        return RadioReciterWidget(
                          sheikhName: reciter.name ?? "Unknown Reciter",
                          audioUrl: audioUrl,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}