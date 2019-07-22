import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'chose_place_provider.dart';
import 'package:sagrado_flutter/src/ui/bottom_navigation/bottom_navigation.dart';

class ChosePlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChosePlaceNotifier placesState = Provider.of<ChosePlaceNotifier>(context);

    final Size size = MediaQuery.of(context).size;
    final double itemHeight = 197;
    final double itemWidth = size.width / 2;

    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: PlatformButton(
          child: Text('Выбрать все'),
          ios: (_) {
            return CupertinoButtonData(padding: EdgeInsets.zero);
          },
          onPressed: () {
            placesState.onAllClick();
          },
        ),
        trailingActions: <Widget>[
          PlatformButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Далее'),
                Icon(Icons.chevron_right),
              ],
            ),
            ios: (_) {
              return CupertinoButtonData(padding: EdgeInsets.zero);
            },
            onPressed: () {
              if (placesState.onCheckPlaces()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WillPopScope(
                      onWillPop: () async {
                        return true;
                      },
                      child: CustomBottomNavigation(),
                    ),
                  ),
                );
              } else {
                showPlatformDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                    title: Text('Выберите хотя бы один клуб'),
                    actions: <Widget>[
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: new Container(
        child: new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: List.generate(
            placesState.places.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Opacity(
                            opacity: placesState.places[index].isSelected
                                ? 0.6
                                : 1.0,
                            child: Image.network(
                              placesState.places[index].imageUrl,
                              fit: BoxFit.fill,
                              width: 167,
                              height: 167,
                            ),
                          ),
                          Image.asset(
                            placesState.places[index].isSelected
                                ? 'assets/images/check-active.png'
                                : 'assets/images/check-inactive.png',
                            width: 24 / 1.2,
                            height: 24 / 1.2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(placesState.places[index].title),
                        ],
                      )
                    ],
                  ),
                  onPressed: () {
                    placesState.onClick(placesState.places[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
