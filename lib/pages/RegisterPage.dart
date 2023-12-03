import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String routeName = '/Register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
    final _formKey = GlobalKey<FormState>();
  
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
  
    bool _isSubmitting = false;
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('TPF Firebase'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isSubmitting = true;
                      });
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message ?? 'An error occurred'),
                          ),
                        );
                      } finally {
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      );
    }
}

