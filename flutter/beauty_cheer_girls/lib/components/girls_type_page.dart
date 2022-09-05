import 'dart:math';
import 'package:beauty_cheer_girls/components/girls_selection_page.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:beauty_cheer_girls/models/spa_girl.dart';

class GirlsTypePage extends StatefulWidget {
  const GirlsTypePage({Key? key}) : super(key: key);

  @override
  State<GirlsTypePage> createState() => _GirlsTypePageState();
}

class _GirlsTypePageState extends State<GirlsTypePage>
    with SingleTickerProviderStateMixin {
  List<SpaGirl> spaGirls = [];

  int? selectedId = null;
  TabController? _tabController = null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future(() async {
      await _getData();
    });
    // if (selectedId != null) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => DesirePage(girlId: selectedId!)
    //     )
    //   )
    // }
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //selectedId = prefs.getInt('selectedGirlId') ?? null;
    });
  }

  Future<void> setGirlsType(String girlsType, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(girlsType, index);
  }

  void moveNextTabView(int nowTabIndex) {
    _tabController!.animateTo(nowTabIndex + 1);
  }

  void moveGirlsSelectionPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GirlsSelectionPage(),
        ));
  }

  void removeSpaGirl(SpaGirl removeTarget) {
    for (var i = 0; i < spaGirls.length; i++) {
      if (spaGirls[i].girlId == removeTarget.girlId) {
        spaGirls.removeAt(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    spaGirls = SpaGirls().create();

    List<SpaGirl> atmosphere1 =
        spaGirls.where((spaGirl) => spaGirl.atmosphere == 1).toList();
    SpaGirl spaGirlsAtmosphere1 =
        atmosphere1[Random().nextInt(atmosphere1.length)];
    removeSpaGirl(spaGirlsAtmosphere1);

    List<SpaGirl> atmosphere2 =
        spaGirls.where((spaGirl) => spaGirl.atmosphere == 2).toList();
    SpaGirl spaGirlsAtmosphere2 =
        atmosphere2[Random().nextInt(atmosphere2.length)];
    removeSpaGirl(spaGirlsAtmosphere2);

    List<SpaGirl> hairType1 =
        spaGirls.where((spaGirl) => spaGirl.hairType == 1).toList();
    SpaGirl spaGirlsHairType1 = hairType1[Random().nextInt(hairType1.length)];
    removeSpaGirl(spaGirlsHairType1);

    List<SpaGirl> hairType2 =
        spaGirls.where((spaGirl) => spaGirl.hairType == 2).toList();
    SpaGirl spaGirlsHairType2 = hairType2[Random().nextInt(hairType2.length)];
    removeSpaGirl(spaGirlsHairType2);

    List<SpaGirl> personality1 =
        spaGirls.where((spaGirl) => spaGirl.personality == 1).toList();
    SpaGirl spaGirlsPersonality1 =
        personality1[Random().nextInt(personality1.length)];
    removeSpaGirl(spaGirlsPersonality1);

    List<SpaGirl> personality2 =
        spaGirls.where((spaGirl) => spaGirl.personality == 2).toList();
    SpaGirl spaGirlsPersonality2 =
        personality2[Random().nextInt(personality2.length)];
    removeSpaGirl(spaGirlsPersonality2);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(138, 196, 251, 1),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
                child: Column(
              children: [
                const SizedBox(height: 100),
                const SelectText(),
                const SizedBox(height: 50),
                Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypeAtmosphere', 1);
                      moveNextTabView(0);
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsAtmosphere1.imageSrc),
                      height: 550,
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypeAtmosphere', 2);
                      moveNextTabView(0);
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsAtmosphere2.imageSrc),
                      height: 550,
                    ),
                  )),
                ]),
              ],
            )),
            Container(
                child: Column(
              children: [
                const SizedBox(height: 100),
                const SelectText(),
                const SizedBox(height: 50),
                Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypeHairType', 1);
                      moveNextTabView(1);
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsHairType1.imageSrc),
                      height: 550,
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypeHairType', 2);
                      moveNextTabView(1);
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsHairType2.imageSrc),
                      height: 550,
                    ),
                  )),
                ]),
              ],
            )),
            Container(
                child: Column(
              children: [
                const SizedBox(height: 100),
                const SelectText(),
                const SizedBox(height: 50),
                Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypePersonality', 1);
                      moveGirlsSelectionPage();
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsPersonality1.imageSrc),
                      height: 550,
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setGirlsType('SelectedTypePersonality', 2);
                      moveGirlsSelectionPage();
                    },
                    child: Ink.image(
                      image: AssetImage(spaGirlsPersonality2.imageSrc),
                      height: 550,
                    ),
                  )),
                ]),
              ],
            ))
          ],
        ));
  }
}

class SelectText extends StatelessWidget {
  const SelectText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'どっちが好きですか？',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
