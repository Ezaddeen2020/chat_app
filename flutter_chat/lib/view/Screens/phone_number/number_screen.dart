// import 'package:chatapp/core/localization/change_local.dart';
// import 'package:chatapp/data/models/country_model.dart';
// import 'package:chatapp/view/Screens/phone_number/countery_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/screens/number_controller.dart';

// class NumberScreen extends GetView<LocaleController> {
//   const NumberScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(NumberControllerImp());

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Enter your phone number",
//           style: TextStyle(
//               color: Colors.teal, fontWeight: FontWeight.bold, wordSpacing: 1),
//         ),
//         centerTitle: true,
//         actions: const [
//           Icon(
//             Icons.more_vert,
//             color: Colors.black,
//           ),
//         ],
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             const Text(
//               "AzoozApp will send an sms message to verfiy your number",
//               style: TextStyle(fontSize: 13.5),
//             ),
//             const SizedBox(height: 5),
//             const Text(
//               "What's my phone ?",
//               style: TextStyle(color: Colors.cyan),
//             ),
//             const SizedBox(height: 15),
//             GetBuilder<NumberControllerImp>(
//               builder: (controller) => countryCard(context, controller),
//             ),
//             const SizedBox(height: 15),
//             numbercard(context),
//             Expanded(child: Container()),
//             GetBuilder<NumberControllerImp>(
//               builder: (controller) => InkWell(
//                 onTap: () {
//                   if (controller.mycontrol.text.length < 9) {
//                     controller.dialogWithNoNum();
//                   } else {
//                     controller.dialogWithNum();
//                   }
//                 },
//                 child: Container(
//                   width: 70,
//                   height: 40,
//                   color: Colors.tealAccent[400],
//                   child: const Center(
//                     child: Text(
//                       "Next",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30)
//           ],
//         ),
//       ),
//     );
//   }

// ///////////////////////////////////////////////////////////////////////////////////////////
//   Widget countryCard(BuildContext context, NumberControllerImp controller) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (builder) => CounteryScreen(
//               setcountry: (CountryModel country) {
//                 controller.setCountry(country.name, country.code, country.flag);
//               },
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.5,
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.teal, width: 2),
//           ),
//         ),
//         child: Row(
//           children: [
//             Obx(() => Text(controller.countryname.value)),
//             const SizedBox(width: 3),
//             Obx(() => Text(controller.countryflag.value)),
//             const Icon(Icons.arrow_drop_down, color: Colors.teal),
//           ],
//         ),
//       ),
//     );
//   }

// //////////////////////////////////////////////////////////////////////////////////////////
//   Widget numbercard(BuildContext context) {
//     return GetBuilder<NumberControllerImp>(
//       builder: (controller) => SizedBox(
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: 40,
//         child: Row(
//           children: [
//             Container(
//               height: 40,
//               padding: const EdgeInsets.only(top: 10),
//               width: 70,
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.teal, width: 2),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   const Text(
//                     "+",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(width: 10),
//                   Obx(
//                     () => Text(
//                       controller.countrycode.value.substring(1),
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(width: 30),
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.teal, width: 2),
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width / 1.5 - 100,
//               height: 40,
//               child: TextFormField(
//                 controller: controller.mycontrol,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   contentPadding: EdgeInsets.all(8),
//                   border: InputBorder.none,
//                   hintText: "phone number",
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
