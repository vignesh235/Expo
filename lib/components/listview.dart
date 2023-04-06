import 'package:expo/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../Screens/Homepage.dart';

Widget myListView(int count) {
  return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: GestureDetector(
                onTap: () {
                  Get.toNamed('/second');
                },
                child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: AppColors.iconcolor,
                        child: const Icon(
                          Icons.list,
                          color: Color(0xffe36c35),
                        )),
                    trailing: const Icon(
                      PhosphorIcons.caret_right,
                    ),
                    subtitle: const Text("Today: 9:00am"),
                    title: Text(
                      "List item $index",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF010418)),
                    ))));
      });
}
