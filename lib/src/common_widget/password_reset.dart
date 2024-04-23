import 'package:ecom/src/common_widget/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }

                  // You can add more email validation here if needed
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed:
                    _emailController.text.isEmpty ? null : _resetPassword,
                child: const Text('Reset Password'),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    buildShowDialog(context);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        context.pop();
        // Show success message or navigate to success screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent successfully'),
          ),
        );
      } catch (error) {
        context.pop();
        print('Error sending password reset email: $error');
        setState(() {
          _errorMessage = 'Failed to send password reset email';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
