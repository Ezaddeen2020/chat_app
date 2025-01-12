import 'package:chat_application/data/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CounteryScreen extends StatelessWidget {
  CounteryScreen({super.key, required this.setcountry});

  final Function setcountry;

  List<CountryModel> countries = [
    CountryModel(name: "Yemen", code: "+967", flag: "🇾🇪"),
    CountryModel(name: "Algeria", code: "+213", flag: "🇩🇿"),
    CountryModel(name: "Egypt", code: "+20", flag: "🇪🇬"),
    CountryModel(name: "Saudi Arabia", code: "+966", flag: "🇸🇦"),
    CountryModel(name: "United Arab Emirates", code: "+971", flag: "🇦🇪"),
    CountryModel(name: "Iraq", code: "+964", flag: "🇮🇶"),
    CountryModel(name: "Jordan", code: "+962", flag: "🇯🇴"),
    CountryModel(name: "Kuwait", code: "+965", flag: "🇰🇼"),
    CountryModel(name: "Lebanon", code: "+961", flag: "🇱🇧"),
    CountryModel(name: "Morocco", code: "+212", flag: "🇲🇦"),
    CountryModel(name: "Tunisia", code: "+216", flag: "🇹🇳"),
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const OtpScreen()),
            // );
            // Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.teal),
        ),
        title: const Text(
          "Choose country",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => card(countries[index]),
      ),
    );
  }

  Widget card(CountryModel country) {
    return InkWell(
      onTap: () {
        setcountry(country);
      },
      child: Card(
        margin: const EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Text(country.flag),
              const SizedBox(width: 15),
              Text(country.name),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(country.code),
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
