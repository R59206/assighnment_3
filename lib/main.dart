import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(StudentFormApp());

class StudentFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leading University Student Form',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: StudentForm(),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _regNoController = TextEditingController();

  bool _isSubmitted = false; // To track submission state
  bool _showForm = true; // To control form visibility

  // Regex patterns for validation
  final String namePattern = r"^[a-zA-Z\s\.]+$"; // Letters, spaces, and dot
  final String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  final String phonePattern = r"^[0-9]{11}$";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isSubmitted) {
          // Reset form and hide the submission details
          setState(() {
            _isSubmitted = false;
            _showForm = true; // Show the form again
            _clearFormFields();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,// Centers the title
          title: Text(
            "Student Registration \n Leading University",
            textAlign: TextAlign.center, // Aligns the text in the middle
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.white, // Set the background color to green
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _showForm ? _buildForm() : _buildSubmittedData(),
        ),
      ),
    );
  }

  // Build the form
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // Full Name Field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              } else if (!RegExp(namePattern).hasMatch(value)) {
                return 'Enter a valid name (letters, spaces, and dot only)';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(emailPattern).hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Phone Number Field
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              } else if (!RegExp(phonePattern).hasMatch(value)) {
                return 'Enter a valid phone number (11 digits)';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Registration Number Field
          TextFormField(
            controller: _regNoController,
            decoration: InputDecoration(
              labelText: 'Registration Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge),
            ),
          ),
          SizedBox(height: 24),

          // Submit Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isSubmitted = true; // Show form submission details
                  _showForm = false;   // Hide the form
                });
              }
            },
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // Build submitted data details
  Widget _buildSubmittedData() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Submitted Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Full Name: ${_nameController.text}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Email: ${_emailController.text}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Phone Number: ${_phoneController.text}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Registration Number: ${_regNoController.text}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Tap anywhere to fill out a new form',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Clear the form fields
  void _clearFormFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _regNoController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _regNoController.dispose();
    super.dispose();
  }
}
