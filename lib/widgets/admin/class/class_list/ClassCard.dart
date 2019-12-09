import 'package:bwa_learning/models/Kelas.dart';
import 'package:bwa_learning/pages/admin/class_list/AddNewClass.dart';
import 'package:bwa_learning/pages/admin/class_list/ViewClass.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ClassItem.dart';

List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.indigo,
  Colors.red,
  Colors.cyan,
  Colors.teal,
  Colors.amber.shade900,
  Colors.deepOrange
];

class ClassCard extends StatelessWidget {

  ClassCard(
      this.kelasData,
      this.level,
      this.tingkat
  );

  final List<Kelas> kelasData;
  final level;
  final tingkat;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          Color color = colorList.elementAt(
              level % colorList.length);

          return Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [buildBoxShadow(color, context)],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {

                  },
                  splashColor: color.withAlpha(20),
                  highlightColor: color.withAlpha(10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                                tingkat == 'sma' && level == 0 ? 'KELAS X' :
                                tingkat == 'sma' && level == 1 ? 'KELAS XI' :
                                'KELAS XII',
                                style: TextStyle(
                                    fontFamily: 'ZillaSlab',
                                    fontSize: 15,
                                    color: Colors.black,
                                )
                            ),
                            Spacer(),
                            RaisedButton.icon(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNewClass(this.level, model),
                                  ),
                                ),
                                icon: Icon(Icons.add_circle),
                                label: Text('Tambah'),
                                color: Colors.green
                            ),
                          ],
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 14),
                          height: 135,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: kelasData.length > 0 ? 5 : 1,
                            children: listMyWidgets(context, model)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        }
    );
  }

  List<Widget> listMyWidgets(BuildContext context, AppModel model) {

    List<Widget> list = new List();

    if (kelasData.length > 0) {
      kelasData.forEach((f) {
        if (level == f.level) {
          list.add(
              ClassItem(
                title: f.className,
                colorBox: Colors.tealAccent,
                onPressed: () {
                  model.setCurrentKelas(f);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewClass(),
                    ),
                  );
                },
              )
          );
        }
      });
    } else {
      list.add(
        Text(
          'Belum ada kelas.',
          textAlign: TextAlign.center,
        )
      );
    }

    return list;
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return BoxShadow(
          blurRadius: 8,
          offset: Offset(0, 8));
    }
    return BoxShadow(
        blurRadius: 8,
        offset: Offset(0, 8));
  }
}
