import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    int currentPageValue = 0;

    return PlatformScaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemCount: 25,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return SizedBox(
                      height: 270,
                      width: double.infinity,
                      child: Carousel(
                        dotBgColor: Colors.transparent,
                        dotIncreaseSize: 3,
                        dotSize: 3,
                        overlayShadowSize: 0,
                        autoplay: false,
                        images: [
                          NetworkImage(
                              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                          NetworkImage(
                              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: 40,
                      child: ListTile(
                        title: new Text('I have border $index'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      appBar: PlatformAppBar(
        title: Text('Акции'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
