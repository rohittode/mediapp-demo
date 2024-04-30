// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/auth_controller.dart';
// import 'package:mediapp/consts/images.dart';
// import 'package:mediapp/consts/strings.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/res/components/custom_textfeild.dart';
import 'package:mediapp/views/appointment_view/appointment_view.dart';
import 'package:mediapp/views/home_view/home.dart';
import 'package:mediapp/views/signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isDoctor = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.icLogin,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                    title: AppStrings.welcomeBack, size: AppSizes.size18),
                AppStyles.bold(title: AppStrings.weAreExcited)
              ],
            ),
            30.heightBox,
            Expanded(
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFeild(
                      hint: AppStrings.email,
                      textController: controller.emailController,
                    ),
                    10.heightBox,
                    CustomTextFeild(
                      hint: AppStrings.password,
                      textController: controller.passwordController,
                    ),
                    10.heightBox,
                    SwitchListTile(value: isDoctor, onChanged:(newValue){
                      setState((){
                          isDoctor = newValue;
                      });

                    },
                    title: "Sign in as a Doctor".text.make()
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.normal(title: AppStrings.forgetPassword),
                    ),
                    20.heightBox,
                    CustomButton(
                        buttonText: AppStrings.login,
                        onTap: () async {
                          await controller.loginUser();
                          if (controller.userCredential != null) {
                            if(isDoctor){
                              Get.to(() => const AppointmentView());
                            }
                            else{
                              Get.to(() => const Home());
                            }
                            
                          }
                        }),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.dontHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const SignupView());
                          },
                          child: AppStyles.bold(title: AppStrings.signup),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
