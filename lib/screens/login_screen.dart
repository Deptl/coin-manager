import 'package:coin_manager/controllers/auth_controller.dart';
import 'package:coin_manager/models/user_model.dart';
import 'package:coin_manager/screens/home_screen.dart';
import 'package:coin_manager/screens/signup_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/strings.dart';
import 'package:coin_manager/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
  bool _validateEmail(String email) {
    final expression = RegExp(emailPattern);
    return expression.hasMatch(email);
  }

  bool isObscured = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset("assets/images/login-image.png"),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 360,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Strings.welcomeMessage,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const SizedBox(height: 5),
                        Text(Strings.loginMessage,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.envelope,
                                      color: secondary,
                                    ),
                                  ),
                                  labelText: "Email",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: secondary, // Set the active color
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: secondary, // Set the active color
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    fontFamily: "Poppins", color: secondary),
                                controller: _emailTextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    Toast.showToast("Enter email address");
                                  } else if (!_validateEmail(value)) {
                                    Toast.showToast(
                                        "Please enter valid email address");
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                obscureText: isObscured,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.lock,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isObscured = !isObscured;
                                          });
                                        },
                                        icon: isObscured
                                            ? const FaIcon(
                                                FontAwesomeIcons.eyeSlash,
                                                color: secondary,
                                                size: 18)
                                            : const FaIcon(FontAwesomeIcons.eye,
                                                color: secondary, size: 18)),
                                  ),
                                  labelText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: secondary, // Set the active color
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: secondary, // Set the active color
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    fontFamily: "Poppins", color: secondary),
                                controller: _passwordTextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    Toast.showToast("Please enter password");
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              isLoading
                                  ? SpinKitThreeBounce(
                                      color: primary,
                                      size: 40.0,
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final email =
                                              _emailTextEditingController.text
                                                  .trim();
                                          final password =
                                              _passwordTextEditingController
                                                  .text
                                                  .trim();
                                          try {
                                            UserModel? user =
                                                await AuthController()
                                                    .loginUser(email, password);

                                            if (user != null) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(),
                                                  ),
                                                  (route) => false);
                                            }
                                          } catch (e) {
                                            Toast.showToast(
                                                "Invalid credentials");
                                          } finally {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primary),
                                      child: Text("Log In",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              color: background))),
                              const SizedBox(height: 10),
                              const Divider(color: secondary),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("First Time here?",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: secondary)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()),
                                        );
                                      },
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.blue.shade400)))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
