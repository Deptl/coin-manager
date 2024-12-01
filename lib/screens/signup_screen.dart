import 'package:coin_manager/controllers/auth_controller.dart';
import 'package:coin_manager/models/user_model.dart';
import 'package:coin_manager/screens/home_screen.dart';
import 'package:coin_manager/screens/login_screen.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  bool isObscured = true;
  bool isLoading = false;

  final String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
  bool _validateEmail(String email) {
    final expression = RegExp(emailPattern);
    return expression.hasMatch(email);
  }

  _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      final user = UserModel(
          userId: "",
          firstName: _firstNameTextEditingController.text.toString(),
          lastName: _lastNameTextEditingController.text.toString(),
          email: _emailTextEditingController.text.toString(),
          hashPassword: "",
          createdAt: DateTime.now());

      await _authController.createUser(
          user, _passwordTextEditingController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: Image.asset("assets/images/signup-image.png"),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 295,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Strings.joinMessage,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 5),
                      Text(Strings.signupMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "First Name",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.user,
                                    color: secondary,
                                  ),
                                ),
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
                              controller: _firstNameTextEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  final fnSnackbar1 = SnackBar(
                                      content: Text("Please enter First Name",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(fnSnackbar1);
                                } else if (value.length < 2) {
                                  final fnSnackbar2 = SnackBar(
                                      content: Text(
                                          "First name Should be more than 2 characters",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(fnSnackbar2);
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Last Name",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.user,
                                    color: secondary,
                                  ),
                                ),
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
                              controller: _lastNameTextEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  final lnSnackbar1 = SnackBar(
                                      content: Text("Please enter Last Name",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(lnSnackbar1);
                                } else if (value.length < 2) {
                                  final lnSnackbar2 = SnackBar(
                                      content: Text(
                                          "Last Name should be more than 2 characters",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(lnSnackbar2);
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Email Address",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.envelope,
                                    color: secondary,
                                  ),
                                ),
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
                                  final emailSnackbar1 = SnackBar(
                                      content: Text("Please enter your email",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(emailSnackbar1);
                                } else if (!_validateEmail(value)) {
                                  final emailSnackbar1 = SnackBar(
                                      content: Text("Please enter valid email",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(emailSnackbar1);
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: isObscured,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: FaIcon(FontAwesomeIcons.lock),
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
                                                color: secondary, size: 18))),
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
                                  final passSnackbar1 = SnackBar(
                                      content: Text("Please enter password",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(passSnackbar1);
                                } else if (value.length < 8) {
                                  final passSnackbar2 = SnackBar(
                                      content: Text(
                                          "Please enter more than 8 characters",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(passSnackbar2);
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            isLoading
                                ? SpinKitThreeBounce(
                                    color: primary,
                                    size: 40.0,
                                  )
                                : ElevatedButton(
                                    onPressed: _signUp,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primary),
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            color: background))),
                            const SizedBox(height: 3),
                            const Divider(color: secondary),
                            const SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Already Have An Account?",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: secondary)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    child: Text("Log In",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
