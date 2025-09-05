import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/util/imosys_app_wrapper.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_field.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_auth/providers/auth_provider.dart';
import 'package:pocket_library/feature_auth/screens/registration_screen.dart';
import 'package:pocket_library/feature_home/screens/home_screen.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool dontShowText = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: AppStrings.fillInFields,
              align: TextAlign.center,
              size: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginUser(
      phone: phone,
      password: password,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: AppStrings.successfullLogIn,
              align: TextAlign.center,
              size: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: authProvider.errorMessage ?? AppStrings.logInFailed,
              align: TextAlign.center,
              size: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _goToRegister() {
    Navigator.of(
      context,
    ).push(SlideLeftRoute(page: const RegistrationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final config = ImosysAppWrapper.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.welcomeBack,
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImosysTextWidget(
                    text: AppStrings.login,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    align: TextAlign.center,
                  ),
                  SizedBox(height: config.defaultVerticalMargin),
                  ImosysTextField(
                    hint: "",
                    controller: _phoneController,
                    hasBorder: true,
                    label: "Phone Number",
                    fillColor: Colors.grey.withAlpha(80),
                    hintFontColor: Colors.grey,
                    inputType: TextInputType.number,
                  ),

                  SizedBox(height: config.defaultVerticalMargin),
                  ImosysTextField(
                    hint: "",
                    controller: _passwordController,
                    hasBorder: true,
                    label: "Password",
                    fillColor: Colors.grey.withAlpha(80),
                    hintFontColor: Colors.grey,
                    inputType: TextInputType.visiblePassword,
                    dontShowText: dontShowText,
                    toggleObscure: () {
                      setState(() {
                        dontShowText = !dontShowText;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: auth.isLoading ? null : _submit,
                          child: auth.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : ImosysTextWidget(
                                  text: AppStrings.login,
                                  size: config.defaultFontSize,
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _goToRegister,
                    child: Text(AppStrings.notHaveAcount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
