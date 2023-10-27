import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class registration extends StatefulWidget {
   final bool isEdit;
 final String? documentId;

  registration({this.isEdit = false,this.documentId});
  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final CollectionReference student =FirebaseFirestore.instance.collection('student');

 

Future<void> fetchUserData() async {
  DocumentSnapshot userSnapshot = await student.doc(widget.documentId).get();

  if (userSnapshot.exists) {
    setState(() {
      _firstNameController.text = userSnapshot['Firstname'];
      _lastNameController.text = userSnapshot['Lastname'];
      _phoneNumberController.text = userSnapshot['Phone'];
      _emailController.text = userSnapshot['Email'];
      _selectedGender = userSnapshot['Gender'];
      _dobController.text = userSnapshot['Dob'];
      _nationalityController.text = userSnapshot['Nationality'];
      _BuildingController.text = userSnapshot['Building'];
      _localityController.text = userSnapshot['Locality'];
      _cityController.text = userSnapshot['City'];
      _pincodeController.text = userSnapshot['Pincode'];
    });
  }
}


void addStudent(){
  final data ={
'Firstname':_firstNameController.text.toLowerCase(),
'Lastname':_lastNameController.text,
'Phone':_pincodeController.text,
'Email':_emailController.text,
'Gender':_selectedGender,
'Dob':_dobController.text,
'Nationality':_nationalityController.text,
'Building':_BuildingController.text,
'Locality':_localityController.text,
'City':_cityController.text,
'Pincode':_pincodeController.text,





  };
  widget.isEdit?student.doc(widget.documentId).update(data):student.add(data);
}

  List<String> _genderOptions= ["Male", "Female", "Others"];
   String? _selectedGender;
  DateTime? _selectedDate;
  final _dateFormat = DateFormat('dd-MM-yyyy');
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController  = TextEditingController();
  final TextEditingController _lastNameController   = TextEditingController();
  final TextEditingController _emailController      = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController         = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _BuildingController    = TextEditingController();
  final TextEditingController _cityController        = TextEditingController();
  final TextEditingController _localityController    = TextEditingController();
  final TextEditingController _pincodeController     = TextEditingController();

   @override
void initState() {
  super.initState();

  if (widget.isEdit) {
    fetchUserData();
  }
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(key:  _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.isEdit ? "Update Details" : "New Student?",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "General Details",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .60,
                        child: TextFormField(
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;},
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              labelText: "First Name",
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .30,
                        child: TextFormField(
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                          controller:_lastNameController ,
                          decoration: InputDecoration(
                            labelText: " Last Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * .50,
                    child:  DropdownButtonFormField<String>(
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: _genderOptions.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  
                ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * .80,
                    child: TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                          labelText: "Phone number",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * .80,
                    child: TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .50,
                         child:TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                          onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                          _dobController.text = _dateFormat.format(_selectedDate!);
                          
                        });
                                        }
                                      },
                           controller: _dobController,
                           decoration: InputDecoration(
                               labelText: "Date of birth",
                               prefixIcon: Icon(Icons.calendar_month),
                               border: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.black))),
                         ),
                      ),
                      SizedBox(
                        width: size.width * .40,
                        child: TextFormField(
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                          controller: _nationalityController,
                          decoration: InputDecoration(
                            labelText: "Nationality",
                            prefixIcon: Icon(Icons.flag),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Address",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * .80,
                    child: TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                      controller: _BuildingController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          labelText: "Building name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width * .80,
                    child: TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                        controller:_localityController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: "Locality",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .50,
                        child: TextFormField(  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                          controller:_cityController,
                          decoration: const InputDecoration(
                              labelText: "City",
                              prefixIcon: Icon(Icons.location_city_rounded),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .40,
                        child: TextFormField(validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;},
                            controller:_pincodeController,
                          decoration: InputDecoration(
                            labelText: "Pincode",
                            prefixIcon: Icon(Icons.location_on_outlined),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * .40,
                      height: size.height * .05,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .40,
                      height: size.height * .05,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: widget.isEdit?ElevatedButton(onPressed: (){addStudent();
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updation Successful"),
                       duration: Duration(seconds: 2),));
        Navigator.pop(context);
        }, child: Text('Update'),style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),):
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[400],
                        ),
                        onPressed: () {if (_formKey.currentState!.validate()) {

          addStudent();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful"),duration: Duration(seconds: 2),));
        Navigator.pop(context);
                     
                    }
                          },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
