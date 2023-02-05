import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/firebaseDatabase.dart';

class SaveEmployee extends StatefulWidget {
  const SaveEmployee({Key? key}) : super(key: key);

  @override
  State<SaveEmployee> createState() => _SaveEmployeeState();
}

class _SaveEmployeeState extends State<SaveEmployee> {


  TextEditingController employeeEditingController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Employee"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25,),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    maxLength: 20,
                    validator: (val) => (val==null||val.isEmpty) ?'Enter The Employee Name!' : null,
                    controller: employeeEditingController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveEmployee,
        tooltip: 'Save Employee',
        child: const Icon(Icons.date_range),
      ),
    );
  }

  void _saveEmployee() async{
    if(_formKey.currentState!.validate()){
      await pickDateTime(context);

      DateTime time = DateTime.now();

      var employee = Employee(
          time.microsecondsSinceEpoch.toString(),
          employeeEditingController.text,
          dateTime.year.toString()
      );

      await DatabaseService().addEmployee(employee.toMap());
      Navigator.pop(context);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null){
      return;
    }
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month+1),
    );
    if (newDate == null) {
      return initialDate;
    }
    return newDate;
  }

}
