import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/list.dart';
import 'package:mediapp/controlers/auth_controller.dart';
import 'package:mediapp/controlers/settings_controller.dart';
import 'package:mediapp/views/login_view/login_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
            title: AppStrings.settings,
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(AppAssets.imgDoctor),
                    ),
                    title: AppStyles.bold(title: controller.username.value),
                    subtitle: AppStyles.normal(title: controller.email.value),
                  ),
                  const Divider(),
                  10.heightBox,
                  ListView(
                    shrinkWrap: true,
                    children: List.generate(
                        settingsList.length,
                        (index) => ListTile(
                              onTap: () async {
                                if (index == 2) {
                                  AuthController().signout();
                                  Get.offAll(() => const LoginView());
                                }
                              },
                              leading: Icon(
                                settingsListIcon[index],
                                color: AppColors.blueColor,
                              ),
                              title: AppStyles.bold(title: settingsList[index]),
                            )),
                  )
                ],
              ),
      ),
    );
  }
}
