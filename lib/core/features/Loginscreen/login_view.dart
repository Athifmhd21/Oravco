import 'package:flutter/material.dart';
import 'package:ecommerce/core/features/Loginscreen/login_viewmodel.dart';
import 'package:ecommerce/core/widgets/textfield.dart';
import 'package:ecommerce/core/features/homescreen/home_view.dart';
import 'package:ecommerce/core/themepro.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel viewModel = LoginViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return FloatingActionButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            child: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          );
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ORAVCO",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                CustomTextField(
                  label: "Email",
                  controller: viewModel.emailController,
                  validator: viewModel.validateEmail,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: "Password",
                  controller: viewModel.passwordController,
                  validator: viewModel.validatePassword,
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {
                    if (viewModel.validateForm()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
