import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            BalanceHistory(),
            Divider(
              color: Colors.black,
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 25,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (context, int index) {
                  return Container(
                    height: 40,
                    child: ListTile(
                      title: new Text('I have border $index'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: PlatformAppBar(
        leading: PlatformButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.chevron_left),
              Text('Назад'),
            ],
          ),
          ios: (_) {
            return CupertinoButtonData(padding: EdgeInsets.zero);
          },
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class BalanceHistory extends StatelessWidget {
  const BalanceHistory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  'БАЛАНС',
                  style: TextStyle(
                    fontFamily: 'Circe',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'ПО СОСТОЯНИЮ НА',
                  style: TextStyle(fontFamily: 'Circe', fontSize: 9),
                ),
                Text(
                  '09:11 11.02.19',
                  style: TextStyle(
                    fontFamily: 'Circe',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              '5000' + ' ₽',
              style: TextStyle(
                  fontFamily: 'Circe',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
