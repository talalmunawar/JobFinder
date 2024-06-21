import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:job_finder/View/Utils/common_field.dart';
import '../../Controller/firebase_auth_controller.dart';
import '../Utils/Styles/app_colors.dart';
import '../Utils/Styles/text_styles.dart';
import '../Utils/login_button.dart';
import 'forget_password.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  FirebaseController firebaseController = Get.put(FirebaseController());

  bool isLoading = false;
  bool show = false;

  void showPassword() {
    if (show) {
      show = false;
    } else {
      show = true;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back',
                    style: CustomTextStyles.titleStyle,
                  ),
                  const Text(
                    'Sign in your account to continue',
                    style: CustomTextStyles.smallGreyColorStyle,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Email Id',
                    style: CustomTextStyles.simpleFontFamily,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextField(
                    ketboardType: TextInputType.emailAddress,
                    hintText: "abc@example.com",
                    controller: emailcontroller,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Email must be given";
                      } else if (!EmailValidator.validate(val)) {
                        return "In-Correct Email Format";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Password',
                    style: CustomTextStyles.simpleFontFamily,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextField(
                    hintText: "* * * * *",
                    controller: passwordcontroller,
                    ketboardType: TextInputType.text,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Password field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 1,
                    icon: IconButton(
                      icon: show
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: showPassword,
                    ),
                    obsecureText: show ? false : true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgetPasswordScreen();
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: const Text(
                            'Forgot Password',
                            style: CustomTextStyles.smallThemedColorStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: CommonButton(
                      child: Obx(
                        () => firebaseController.loader.value
                            ? CircularProgressIndicator(
                                color: AppColors.whiteColor,
                              )
                            : Text(
                                'Login',
                                style: CustomTextStyles.commonButtonStyle,
                              ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          firebaseController.signInWithEmailAndPassword(
                            emailcontroller.text,
                            passwordcontroller.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: CustomTextStyles.smallGreyColorStyle,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RegisterScreen();
                      },
                    ));
                  },
                  child: const Text(
                    'SignUp',
                    style: CustomTextStyles.smallThemedColorStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
