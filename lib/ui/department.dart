import 'package:flutter/material.dart';

List<String> departmentMembers = [
  'Seema Mahajan',
  'Bhoomi Trivedi',
  'Jignesh Patel',
  'Manisha Valera',
  'Roshni Patel',
  'Zalak Trivedi',
  'Divyesh Joshi',
  'Madhvi Bera',
  'Sejal Thakkar',
  'Dhaval Patel',
  'Naiswita Parmar',
  'Kavita Pandya',
  'Raunak Patel',
  'Khushbu Maurya',
  'Jay Dave',
  'Bhavin Fataniya',
  'Srishti Sharma',
];

class DepartmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Department'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) => InkWell(
              splashColor: Colors.white,
              child: ListTile(
                title: Text(departmentMembers[i]),
                onTap: () {},
              ),
            ),
        itemCount: departmentMembers.length,
      ),
    );
  }
}
