import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_games/widgets/buttons/icon_elevated_Button.dart';
import 'package:math_games/widgets/input/input_custome.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  var isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset("assets/images/wave.svg", fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 50),
                //Title Login
                Text(
                  isLogin ? "Login" : "Sign up",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                  //
                ),
                // login and sign up
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // login
                    const InputCustume(
                        hintText: "enter user name",
                        icon: Icon(Icons.person_2_outlined),
                        obscureText: false),
                    const SizedBox(
                      height: 16,
                    ),
                    //password
                    const InputCustume(
                        hintText: "enter password",
                        icon: Icon(Icons.lock),
                        obscureText: true),
                    const SizedBox(
                      height: 50,
                    ),
                    //login button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        isLogin ? "Login" : "Sign up",
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //switch login<->sign up button

                    TextButton(
                        onPressed: () {},
                        child: Text(
                          isLogin ? "Forgot your password?" : "",
                          style: const TextStyle(color: Colors.white60),
                        )),

                    //Divider
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "other conect with",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    //conext with facebook
                    const SizedBox(
                      height: 24,
                    ),
                    Row(children: [
                      //login with facebook
                      const IconElevatedButton(
                          label: "Facebool",
                          icon: Icon(Icons.facebook),
                          color: Colors.blue),

                      const SizedBox(width: 20),
                      // login with twitter
                      IconElevatedButton(
                        label: "Twitter",
                        icon: const Icon(Icons.brightness_2_rounded),
                        color: Colors.indigo.shade800,
                      ),
                    ]),
                    const SizedBox(height: 16),
                    // switch to Login/Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin ? "Don't have account?" : "i have account",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? "Sign up" : "login",
                          ),
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
