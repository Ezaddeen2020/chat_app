// import 'package:chat_application/view/Screens/phone_number/number_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SafeArea(
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               _buildWelcomeText(),
//               SizedBox(height: MediaQuery.of(context).size.height / 8),
//               _buildImage(),
//               SizedBox(height: MediaQuery.of(context).size.height / 8),
//               _buildTermsText(context),
//               const SizedBox(height: 20),
//               _buildAgreeButton()
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeText() {
//     return const Text(
//       "Welcome to AzoozApp",
//       style: TextStyle(
//         color: Colors.teal,
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget _buildImage() {
//     return Image.asset(
//       "assets/images/bg.png",
//       color: const Color(0xFF25D366),
//       height: 300,
//       width: 300,
//     );
//   }

//   Widget _buildTermsText(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//           style: TextStyle(color: Colors.grey[600], fontSize: 16),
//           children: const [
//             TextSpan(text: "Agree and Continue to accept the "),
//             TextSpan(
//               text: "AzoozApp Terms of service and Privacy Policy.",
//               style: TextStyle(color: Colors.cyan),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAgreeButton() {
//     return InkWell(
//       onTap: () {
//         Get.to(() => const NumberScreen());
//       },
//       child: SizedBox(
//         width: Get.width - 110,
//         height: 50,
//         child: const Card(
//           margin: EdgeInsets.all(0),
//           color: Color.fromARGB(255, 8, 92, 38),
//           elevation: 8,
//           child: Center(
//             child: Text(
//               "AGREE AND CONTINUE",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
