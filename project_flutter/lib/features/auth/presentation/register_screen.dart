import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter/core/constants/constants.dart';
import 'package:project_flutter/features/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: kLabelStyle),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: Icon(icon, color: Colors.white),
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: auth.isLoading
                ? null
                : () async {
                    final firstName = _firstNameController.text.trim();
                    final lastName = _lastNameController.text.trim();
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final confirmPassword = _confirmPasswordController.text
                        .trim();

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    try {
                      final user = await auth.registerUser(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        password: password,
                      );

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Registration successful"),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: auth.isLoading
                ? const CircularProgressIndicator(color: Color(0xFF527DAA))
                : const Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      letterSpacing: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 120,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    _buildTextField(
                      label: 'First Name',
                      hint: 'Enter your first name',
                      icon: Icons.person,
                      controller: _firstNameController,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Last Name',
                      hint: 'Enter your last name',
                      icon: Icons.person_outline,
                      controller: _lastNameController,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      icon: Icons.email,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock,
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                      icon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      obscureText: true,
                    ),

                    _buildRegisterBtn(),
                    const SizedBox(height: 20),
                    _buildLoginLink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
