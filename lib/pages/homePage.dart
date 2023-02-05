import 'package:employee/models/employee.dart';
import 'package:employee/pages/saveEmployee.dart';
import 'package:flutter/material.dart';

import '../services/firebaseDatabase.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Employee>>(
        stream: DatabaseService().getAllEmployeeList,
        builder: (context, snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            if(snapshot.data?.length != 0){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){

                  Employee employee = snapshot.data![index];

                  return ListTile(
                    title: Text(employee.employeeName),
                    subtitle: Text(employee.employeeDate),
                    trailing: CircleAvatar(
                      backgroundColor: (2023 - int.parse(employee.employeeDate.toString()))<=5 ? Colors.grey: Colors.green,
                    ),
                  );
                },
              );
            }else if (snapshot.data?.length == 0){
              return SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: Center(
                  child: Text(
                    "No Employee",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[400]
                    ),
                  ),
                ),
              );
            }else{
              return Container();
            }
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigate,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigate() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SaveEmployee()));
  }


}