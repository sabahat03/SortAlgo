import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Login Screen",
              style: TextStyle(
                color: Colors.white,
              ),),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Enter Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),

                            onChanged: (String value){

                            },
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Email can't be empty";
                              }

                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 30,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Enter Password",
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(),
                            ),

                            onChanged: (String value){

                            },
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Password can't be empty";
                              }

                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: MaterialButton(
                            minWidth: double.infinity,

                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
                              );
                            },
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: Text("Login"),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        )
    );
  }
}
