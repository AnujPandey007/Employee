class Employee {

  late final String _employeeId;
  late final String _employeeName;
  late final String _employeeDate;

  Employee(this._employeeId, this._employeeName, this._employeeDate);

  String get employeeId => _employeeId;
  String get employeeName => _employeeName;
  String get employeeDate => _employeeDate;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["employeeId"] = _employeeId;
    map["employeeName"] = _employeeName;
    map["employeeDate"] = _employeeDate;
    return map;
  }
}