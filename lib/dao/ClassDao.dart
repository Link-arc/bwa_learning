import 'package:bwa_learning/dao/Config.dart';
import 'package:bwa_learning/models/Class.dart';
import 'package:mysql1/mysql1.dart';

class ClassDao {

  static final ClassDao db = ClassDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Class>> getClass() async {
    print("getKelas");
    var db = await database;

    List<Class> classList = [];

    var res = await db.query("SELECT * FROM class");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        classList.add(Class.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return classList;
  }

  Future<List<Class>> getClassByIdInstitution(int idInstitution) async {
    print("getKelasByIdInstitution");
    var db = await database;

    List<Class> classList = [];

    var res = await db.query("SELECT * FROM class where idInstitution = $idInstitution");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        classList.add(Class.fromJson(f.fields));
      });
    }
    else{
      print("Null");
    }

    return classList;
  }

  Future<Class> getClassByName(String className, int idInstitution) async {
    print("getKelasByName");
    var db = await database;
    var res = await db.query("SELECT * FROM class WHERE className = '$className' and idInstitution = $idInstitution");

    Class findClass;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findClass = Class.fromJson(f.fields);
      });
      return findClass;
    }
    return null;
  }

  Future<Class> getClassById(int idClass, int idInstitution) async {
    print("getClassById");
    var db = await database;
    var res = await db.query("SELECT * FROM class WHERE idClass = '$idClass' and idInstitution = $idInstitution");

    Class findClass;

    if (res.length > 0) {
      res.forEach((f) {
        print(f);
        findClass = Class.fromJson(f.fields);
      });
      return findClass;
    }
    return null;
  }

  Future addClass(Class newClass) async {
    print("addKelas");
    final db = await database;
    await db.query("INSERT INTO class VALUES (${newClass.idClass},'${newClass.className}','${newClass.level}','${newClass.teacherClass}','${newClass.idInstitution}')");

  }

  updateClassById(Class updatedClass, int idClass) async {
    print("updateKelas");
    final db = await database;
    await db.query("UPDATE class SET ${updatedClass.toMap()} WHERE idKelas = $idClass ");
    print('Class updated: ${updatedClass.className}');
  }

}
