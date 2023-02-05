import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee/models/employee.dart';

class DatabaseService{

  ///Employee
  final CollectionReference employeeCollection = FirebaseFirestore.instance.collection("employee");

  // Add Employee
  addEmployee(employeeRoom) async{
    await employeeCollection.doc().set(employeeRoom).catchError((e) {
      print(e);
    });
  }

  // List of Employee
  List<Employee> employeeList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Employee(
        doc.get("employeeId"),
        doc.get("employeeName"),
        doc.get("employeeDate"),
      );
    }).toList();
  }

  Stream<List<Employee>> get getAllEmployeeList {
    return employeeCollection.snapshots().map(employeeList);
  }
}