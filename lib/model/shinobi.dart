
class Shinobi {

  int? id;
  String? name;
  String? level;
  String? power;
  String? teacher;

  Shinobi({this.id, this.name, this.level, this.power, this.teacher});

  Shinobi.fromMap(Map<String, dynamic> map) {

    this.id = map['id_column'];
    this.name = map['name_column'];
    this.level = map['level_column'];
    this.power = map['power_column'];
    this.teacher = map['teacher_column'];

  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      "name_column" : this.name,
      "level_column" : this.level,
      "power_column" : this.power,
      "teacher_column" : this.teacher,
    };
    if(id != null) {
      map['id_column'] = this.id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Shinobi{Id: $id, Name: $name, Level: $level, Power: $power, Teacher: $teacher}';
  }

}