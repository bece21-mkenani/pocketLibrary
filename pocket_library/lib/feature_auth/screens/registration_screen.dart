import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/imosys_flutter_package.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_auth/providers/auth_provider.dart';
import 'package:pocket_library/feature_auth/screens/otp_screen.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool dontShowText = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (fullName.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: '${AppStrings.texFiledWarning}.',
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

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: '${AppStrings.passwordWarning}.',
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
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final success = await authProvider.registerUser(
      fullName: fullName,
      phone: phone,
      password: password,
    );

    if (success) {
      messenger.showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text: '${AppStrings.registrationSuccessful}.',
              align: TextAlign.center,
              size: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => OTPScreen(phone: phone)),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Center(
            child: ImosysTextWidget(
              text:
                  authProvider.errorMessage ??
                  '${AppStrings.registrationfailed}.',
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

  @override
  Widget build(BuildContext context) {
    final config = ImosysAppWrapper.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.createAccount,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImosysTextWidget(
                    text: AppStrings.joinUs,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      fontSize: config.defaultFontSize,
                    ),
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ImosysTextField(
                    hint: "",
                    controller: _fullNameController,
                    hasBorder: true,
                    label: "Full name",
                    fillColor: Colors.grey.withAlpha(80),
                    hintFontColor: Colors.grey,
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: auth.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : ImosysTextWidget(
                                  text: AppStrings.register,
                                  size: config.defaultFontSize,
                                  color: Colors.white,
                                ),
                        ),
                      );
                    },
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
