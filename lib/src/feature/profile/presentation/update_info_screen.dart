import 'dart:developer';

import 'package:ecom/src/common_widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class UpdateUserInfoForm extends StatefulWidget {
  const UpdateUserInfoForm({super.key});

  @override
  _UpdateUserInfoFormState createState() => _UpdateUserInfoFormState();
}

class _UpdateUserInfoFormState extends State<UpdateUserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _usernameController
                  ..text = FirebaseAuth.instance.currentUser!.displayName!,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                controller: _emailController
                  ..text = FirebaseAuth.instance.currentUser!.email!,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more email validation here if needed
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _updateUserInfo,
                child: const Text('Update Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserInfo() async {
    buildShowDialog(context);
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName(_usernameController.text.trim());
        if (_emailController.text.trim() != user.email) {
          await user.verifyBeforeUpdateEmail(_emailController.text.trim());
        }
        context.pop();
        // Show success message or navigate to success screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User info updated successfully'),
          ),
        );
      } catch (error) {
        log(error.toString());
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ));
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    home: UpdateUserInfoForm(),
  ));
}
