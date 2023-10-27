import 'package:flutter/material.dart';
import 'package:task_one_reg/screens/firstPage.dart';

class homePage extends StatefulWidget{
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Welcome to",style: TextStyle(fontWeight:FontWeight.bold, fontSize:26,decoration: TextDecoration.none,color: Colors.black),),
               ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(" S T U D E N T L O G",style: TextStyle(fontSize: 20,decoration: TextDecoration.none,color: Colors.black),),
                ),
    
         Image(image: AssetImage("assets/splash.png")),
        SizedBox(height:30 ,),
      
           Container( 
            width: size.width*.40,
            height:size.height*.05,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
              ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>firstPage()));
              },
              child: const Text(
              "Register Now",
                style: TextStyle(fontSize: 18),
              ),
            ),
             ),
        
           
        ],
      ),
    );
  }
}