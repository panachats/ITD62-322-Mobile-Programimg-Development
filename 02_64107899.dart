class Person {
  String? _name;
  int? _height;
  int? _weight;
  DateTime? _dob;

  String? get name => _name;
  set name(String? value) => _name = value;

  int? get height => _height;
  set height(int? value) => _height = value;

  int? get weight => _weight;
  set weight(int? value) => _weight = value;

  DateTime? get dob => _dob;
  set dob(DateTime? value) => _dob = value;

  Person({String? name, int? height, int? weight, DateTime? dob}) {
    this._name = name;
    this._height = height;
    this._weight = weight;
    this._dob = dob;
  }

  int calculateAge() {
    if (_dob != null) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - _dob!.year;
      // print('Age: $age');
      return age;
    } else {
      // print('Date of birth is not provided.');
      return 0;
    }
  }

  double bmi() {
    if (_height != null && _weight != null && _height! >= 1 && _weight! >= 1) {
      double heightInMeters = _height! / 100.0;
      double result = _weight! / (heightInMeters * heightInMeters);
      // print('BMI: ${result.toStringAsFixed(2)}');
      return result;
    } else {
      // print('Height or weight is not provided.');
      return 0;
    }
  }

  void show() {
    int age = calculateAge();
    double result = bmi();
    var dobStr = _dob.toString();
    if (dobStr.contains(' ')) {
      dobStr = dobStr.substring(0, dobStr.indexOf(' '));
    }
    print(
        'Name: $_name \nBMI: ${result.toStringAsFixed(2)} \nAge: $age \nHeight: $_height \nWeight: $_weight\nDOB: $dobStr\n-----------------------');
  }
}

class Course {
  String? _c_id;
  String? _c_name;
  int? _c_credit;

  String? get c_id => _c_id;
  set c_id(String? value) => _c_id = value;

  String? get c_name => _c_name;
  set c_name(String? value) => _c_name = value;

  int? get c_credit => _c_credit;
  set c_credit(int? value) => _c_credit = value;

  Course({String? c_id, String? c_name, int? c_credit}) {
    this._c_id = c_id;
    this._c_name = c_name;
    this._c_credit = c_credit;
  }

  void show() {
    print(
        'CourseID: $_c_id \nCourseName: $_c_name \nCourseCredit: $_c_credit\n-----------------------');
  }
}

class Student extends Person {
  String? _sid;
  String? _major;
  double? _gpax;
  List<Course>? _listOfCourses;

  String? get sid => _sid;
  set sid(String? value) => _sid = value;

  String? get major => _major;
  set major(String? value) => _major = value;

  double? get gpax => _gpax;
  set gpax(double? value) => _gpax = value;

  List<Course>? get listOfCourses => _listOfCourses;
  set listOfCourses(List<Course>? value) => _listOfCourses = value;

  Student(String? name, {String? sid, String? major, double? gpax})
      : super(name: name) {
    this._sid = sid;
    this._major = major;
    this._gpax = gpax;
    this._listOfCourses = [];
  }

  void register(Course course) {
    _listOfCourses?.add(course);
  }

  @override
  void show() {
    print('Name: $name\nStudent ID: $_sid\nMajor: $_major\nGPAX: $_gpax');
    print('List of Courses:');
    if (_listOfCourses != null && _listOfCourses!.isNotEmpty) {
      for (var course in _listOfCourses!) {
        course.show();
      }
    } else {
      print('No courses registered.');
    }
  }
}

void main() {
  Person person1 = Person(
      name: 'Panachat', height: 167, weight: 55, dob: DateTime(2002, 11, 29));
  print('ข้อ 1 และ ข้อ 2');
  person1.show();
  person1.calculateAge();
  person1.bmi();
  Person person2 = Person(
      name: 'Kasidit', height: 170, weight: 76, dob: DateTime(2002, 10, 30));
  person2.calculateAge();
  person2.bmi();
  person2.show();

  print('ข้อ 3');
  Course course1 =
      Course(c_id: 'ITD', c_name: 'Mobile Programming', c_credit: 3);
  course1.show();
  Course course2 =
      Course(c_id: 'ITD', c_name: 'Front-End Programming', c_credit: 3);
  course2.show();

  print('ข้อ 4 และ ข้อ 5');
  Student student = Student('Chat Aiam',
      sid: '64107899',
      major: 'Information Technology and Digital Innovation',
      gpax: 3.5);
  student.register(course1);
  student.register(course2);
  student.show();
}
