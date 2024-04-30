// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/auth_controller.dart';
// import 'package:mediapp/consts/images.dart';
// import 'package:mediapp/consts/strings.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/res/components/custom_textfeild.dart';
import 'package:mediapp/views/home_view/home.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                  AppAssets.imgSignup,
                  width: 200,
                ),
                10.heightBox,
                // AppStyles.bold(title: AppStrings.signup, size: AppSizes.size18),
                AppStyles.bold(
                    title: AppStrings.signupNow,
                    size: AppSizes.size18,
                    alignment: TextAlign.center)
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
                      hint: AppStrings.fullname,
                      textController: controller.fullnameController,
                    ),
                    10.heightBox,
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
                    SwitchListTile(
                      title: "Sign up as a doctor".text.make(),
                      value: isDoctor, 
                      onChanged: (newValue){
                      setState(() {
                        isDoctor = newValue;
                      });
                      }),
                    Visibility(
                      visible: isDoctor,
                      child: Column(
                        children: [
                          CustomTextFeild(
                            hint: "About",
                            textController: controller.aboutController,
                          ),
                          10.heightBox,
                          CustomTextFeild(
                            hint: "Category",
                            textController: controller.categoryController,
                          ),
                          10.heightBox,
                          CustomTextFeild(
                            hint: "Services",
                            textController: controller.servicesController,
                          ),
                          10.heightBox,
                          CustomTextFeild(
                            hint: "Address",
                            textController: controller.addressController,
                          ),
                          10.heightBox,
                          CustomTextFeild(
                            hint: "Phone Number",
                            textController: controller.phoneController,
                          ),
                          10.heightBox,
                          CustomTextFeild(
                            hint: "Timing",
                            textController: controller.timingController,
                          ),
                          10.heightBox,
                        ],
                      ),
                    ),
                    20.heightBox,
                    CustomButton(
                      buttonText: AppStrings.signup,
                      onTap: () async {
                        await controller.signupUser(isDoctor);
                        if (controller.userCredential != null) {
                          Get.offAll(() => const Home());
                        }
                      },
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(title: AppStrings.login),
                        )
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
