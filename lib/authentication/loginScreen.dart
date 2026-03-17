import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/authentication/controller/auth_controller.dart';
import 'package:todo_app/const_assets/imageConst.dart';

//ConstrainedBox - Column height = at least screen height
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginOnPress() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    await _authController.login(context, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  //MediaQuery.of(context).size.height
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 80, child: Image.asset(image)),
                          const SizedBox(height: 8),
                          const Text('Register into Todo List'),
                          const SizedBox(height: 40),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: emailController,
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              hint: const Text('example@gmail.com'),
                              hintStyle: TextStyle(color: Colors.grey[200]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              hint: const Text('******'),
                              hintStyle: TextStyle(color: Colors.grey[200]),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            maxLength: 6,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Password is required';
                            //   }
                            //   if (value.length < 6) {
                            //     return 'Password must be at least 6 characters';
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                loginOnPress();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                ),
                              ),
                              label: const Text("Login"),
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
