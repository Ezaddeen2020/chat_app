
import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/core/localization/change_local.dart';
import 'package:chatapp/view/widgets/language/language_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyLanguage extends GetView<LocaleController> {
  const MyLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1".tr, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 15),
            LanguageButton(
                textbutton: "Ar",
                onPressed: () {
                  controller.changelang("ar");
                  Get.toNamed(AppRoute.login);
                }),
            LanguageButton(
              textbutton: "En",
              onPressed: () {
                controller.changelang("en");
                  Get.toNamed(AppRoute.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
