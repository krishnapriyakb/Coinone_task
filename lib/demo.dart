import 'dart:html';

import 'package:flutter/material.dart';
import 'package:task_one_reg/screens/homePage.dart';
import 'package:task_one_reg/screens/registrationForm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class firstPage extends StatefulWidget {
  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  final CollectionReference student =FirebaseFirestore.instance.collection('student');
  bool isEdit=false;
    final TextEditingController _searchController = TextEditingController(); // Step 1

  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(title: Text("S T U D E N T  L O G"),centerTitle: true,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>registration()));
      },child: Icon(Icons.add),),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration:InputDecoration(prefixIcon: Icon(Icons.search),
              hintText: 'Search here',
              border: OutlineInputBorder()),),
          ),
          Expanded(
            child: StreamBuilder(stream: student.orderBy('Firstname').snapshots(), builder:(context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                
              return ListView.builder(itemCount: snapshot.data!.docs.length,itemExtent: 60, itemBuilder:(context, index) {
                final DocumentSnapshot studentSnap=snapshot.data.docs[index];
                return ListTile(leading:CircleAvatar(child: Icon(Icons.person),),
                title: Text(studentSnap['Firstname'].toString().toUpperCase() + " " + studentSnap['Lastname'].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                subtitle: Text(studentSnap['Email']),
                trailing:Row(mainAxisSize: MainAxisSize.min,
                  children: [IconButton(onPressed: (){
                    isEdit=true;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>registration(isEdit: isEdit,documentId: studentSnap.id,)));
                  }, icon: Icon(Icons.edit)),
                  SizedBox(width: 15,),
                  IconButton(icon:Icon(Icons.delete),onPressed: () {
                   setState(() {
                      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete this entry?'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            
            ElevatedButton( style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),onPressed: () {
            student.doc(studentSnap.id).delete();
             Navigator.of(context).pop(); },
              child: Text('Delete')
            ),
          ],
        );
      },
    );
                   });
   
  }

                    
                    
                  ,)],
                  ) ,
                
                  );
              },);
              }
              return Container();
            },),
          ),
        ],
      ),
    );
  }
}
