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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signupOnPress() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    await _authController.signUp(context, name, phone, email, password);
  }

  void _loginupOnPress() async {
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
                          const SizedBox(height: 25),
                          SizedBox(height: 80, child: Image.asset(image)),
                          const SizedBox(height: 8),
                          Obx(
                            () => Text(
                              _authController.isLogin.value
                                  ? 'Login into Todo List'
                                  : 'Create a Account!',
                            ),
                          ),
                          const SizedBox(height: 40),
                          Obx(() {
                            if (_authController.isLogin.value == false) {
                              return Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      label: const Text('Name'),
                                      hint: const Text('Enter you name'),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[200],
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      label: const Text('Phone'),
                                      hint: const Text(
                                        'Enter your phone number',
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[200],
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    maxLength: 10,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }
                            return SizedBox();
                          }),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                          Obx(
                            () => TextFormField(
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
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    // true -> false and false -> true
                                    _authController.showPass.value =
                                        !_authController.showPass.value;
                                  },
                                  child: Icon(
                                    _authController.showPass.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              obscureText: _authController.showPass.value,
                              maxLength: 6,

                              /// TO USE OF validator: WE WRAP WITH form(_formkey)
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
                          ),
                          const SizedBox(height: 30),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _authController.isLogin.value
                                      ? _loginupOnPress()
                                      : _signupOnPress();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                label: Text(
                                  _authController.isLogin.value
                                      ? "Login"
                                      : "Signup",
                                ),
                                icon: Icon(Icons.login),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                _authController.isLogin.value =
                                    !_authController.isLogin.value;
                                emailController.clear();
                                passwordController.clear();
                              },
                              child: Text(
                                _authController.isLogin.value
                                    ? 'I don\'t have a Account? SignUp!'
                                    : 'I already have Account? Login!',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
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
