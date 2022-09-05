import 'package:beauty_cheer_girls/components/desire_page.dart';
import 'package:beauty_cheer_girls/models/spa_girl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GirlsSelectionPage extends StatefulWidget {
  const GirlsSelectionPage({Key? key}) : super(key: key);

  @override
  State<GirlsSelectionPage> createState() => _GirlsSelectionPageState();
}

class _GirlsSelectionPageState extends State<GirlsSelectionPage> {
  List<SpaGirl> spaGirls = [];
  int? selectedId;
  int? atmosphereType;
  int? hairType;
  int? personalityType;

  @override
  void initState() {
    super.initState();
    Future(() async {
      await _getData();
      if (selectedId != null) {
        moveDesirePage(selectedId!);
      }

      // 選択されているものから抜き出す
      List<SpaGirl> beforeSpaGirls = SpaGirls().create();
      for (var i = 0; i < beforeSpaGirls.length; i++) {
        if (beforeSpaGirls[i].atmosphere == atmosphereType) {
          if (!spaGirls.contains(beforeSpaGirls[i])) {
            spaGirls.add(beforeSpaGirls[i]);
          }
        }
      }
      for (var i = 0; i < beforeSpaGirls.length; i++) {
        if (beforeSpaGirls[i].hairType == hairType) {
          if (!spaGirls.contains(beforeSpaGirls[i])) {
            spaGirls.add(beforeSpaGirls[i]);
          }
        }
      }
      for (var i = 0; i < beforeSpaGirls.length; i++) {
        if (beforeSpaGirls[i].personality == personalityType) {
          if (!spaGirls.contains(beforeSpaGirls[i])) {
            spaGirls.add(beforeSpaGirls[i]);
          }
        }
      }
      for (var i = 0; i < beforeSpaGirls.length; i++) {
        if (!spaGirls.contains(beforeSpaGirls[i])) {
          spaGirls.add(beforeSpaGirls[i]);
        }
      }
    });
  }

  void moveDesirePage(int girlId) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DesirePage(girlId: girlId),
        ));
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedId = prefs.getInt('selectedGirlId');
      atmosphereType = prefs.getInt('SelectedTypeAtmosphere');
      hairType = prefs.getInt('SelectedTypeHairType');
      personalityType = prefs.getInt('SelectedTypePersonality');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("どの子の声聞きたい？"),
        backgroundColor: const Color.fromRGBO(138, 196, 251, 1),
      ),
      backgroundColor: const Color.fromRGBO(138, 196, 251, 1),
      body: StaggeredGridView.count(
        crossAxisCount: 4,
        staggeredTiles: List.generate(spaGirls.length, (index) {
          final numPerTile = index < 3 ? 4 : 2;
          return StaggeredTile.fit(numPerTile);
        }),
        children: List.generate(spaGirls.length, (index) {
          return _Tile(
            index: index,
            spaGirl: spaGirls[index],
          );
        }),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  _Tile({required this.index, required this.spaGirl});

  final SpaGirl spaGirl;
  final int index;

  Future<void> _setData(SpaGirl spaGirl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedGirlId', spaGirl.girlId);
  }

  @override
  Widget build(BuildContext context) {
    final width = index < 3 ? 500.0 : 200.0;
    final height = index < 3 ? 500.0 : 250.0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: spaGirl.color, width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        // borderRadius: const BorderRadius.all(Radius.circular(15)),
        // clipBehavior: Clip.hardEdge,
        child: Container(
          // decoration: BoxDecoration(
          // color: Colors.yellow,
          // border: Border.all(width: 1)),
          child: Align(
            alignment: Alignment.topLeft,
            widthFactor: 0.50,
            heightFactor: 0.55,
            child: GestureDetector(
                onTap: () {
                  _setData(spaGirl);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DesirePage(girlId: spaGirl.girlId)));
                },
                child: Image.asset(spaGirl.imageSrc,
                    width: width, height: height)),
          ),
        ),
      ),
    );
  }
}
