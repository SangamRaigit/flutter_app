import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'next.dart';
import 'signup.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'sessionid=167dfd60-b2a9-4078-a964-97dda89fd0f3'
    };
    var url = Uri.parse('http://10.0.2.2:3000/users/login');
    var body = json.encode({
      "username": _emailController.text,
      "password": _passwordController.text
    });

    var response = await http.post(url, headers: headers, body: body);
    var responseBody = json.decode(response.body);
    if (responseBody['code'] == 200) {
      print('Sign in successful');
      print(await response.body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => next(username: _emailController.text)),
      );
    } else {
      print('Sign in failed: ${response.reasonPhrase}');
      // Handle login failure here, show error message or take appropriate action
      // For example, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: ${responseBody['message']}')),
      );
    }
  } catch (error) {
    print('Error signing in: $error');
    // Handle any unexpected errors here
    // For example, show a snackbar with the error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error signing in. Please try again later.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/Synapse_logo.svg',
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, top: 40.0),
                child: Text(
                  'Sign In',
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 0.0),
                          child: GestureDetector(
                            onTap: () {
                              // Handle forgot password action here
                              print('Forgot Password tapped');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
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
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Or',
                          style: TextStyle(fontSize: 18),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Text(
                      '2020-2021. All Rights Reserved',
                      style: TextStyle(fontSize: 14.0, color: const Color(0xFF9B9B9B).withOpacity(0.5)),
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

                     
