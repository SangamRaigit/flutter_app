import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 100.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Text(
                          'Name',
                          style: TextStyle(fontSize: 14.0, color: const Color(0xFF747475).withOpacity(0.5),),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Text(
                          'Email id',
                          style: TextStyle(fontSize: 14.0, color: const Color(0xFF747475).withOpacity(0.5),),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Text(
                          'Password',
                          style: TextStyle(fontSize: 14.0, color: const Color(0xFF747475).withOpacity(0.5)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Enter password',
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: _isObscure,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  _isObscure ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Prepare the data to send in the request body
                        Map<String, String> data = {
                          'username': _nameController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                        };
                        // Send the POST request
                        var url = Uri.parse('http://10.0.2.2:3000/users');
                        var response = await http.post(url, body: data);
                        var responseBody = json.decode(response.body);
                        if (responseBody['code'] == 200) {
                          print('Sign up successful');
                          print(await response.body);
                          // Navigate to the next screen or perform any other actions upon successful sign up
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        } else {
      print('Sign up failed: ${response.reasonPhrase}');
      // Handle login failure here, show error message or take appropriate action
      // For example, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: ${responseBody['message']}')),
      );
    }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
