import 'package:bwa_learning/models/Student.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/student/StudentCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

class StudentListView extends StatelessWidget {
  final List<Student> student;

  StudentListView(this.student);

  Widget _buildEmptyText(AppModel model) {
    String emptyText;

    emptyText = 'Belum ada kelas. \r\nAyo coba buat kelas.';

    Widget svg = new SvgPicture.asset(
      'assets/img/todo_list.svg',
      width: 200,
    );

    return Container(
      color: Color.fromARGB(16, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          svg,
          SizedBox(
            height: 40.0,
          ),
          Text(
            emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.lightBlue
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(AppModel model) {
    return ListView.builder(
      itemCount: student.length,
      itemBuilder: (BuildContext context, int index) {
        return StudentCard(student[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Widget kelasCards = student.length > 0
            ? _buildListView(model)
            : _buildEmptyText(model);

        return kelasCards;
      },
    );
  }
}