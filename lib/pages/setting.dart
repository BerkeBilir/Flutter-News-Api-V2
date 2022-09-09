import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: ColorTheme().backgroundColor,
        body: SafeArea(
          child: Column(children: [
            Container(
                padding: EdgeInsets.only(top: 20.0),
                width: width,
                color: ColorTheme().backgroundColor,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                          child: Text('Ayarlar',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: ColorTheme().textColor))),
                      Positioned(
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorTheme().buttonColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: ColorTheme().shadowColor,
                                  spreadRadius: 0.1)
                            ],
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                color: ColorTheme().cardColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      color: ColorTheme().shadowColor,
                                      spreadRadius: 0.1)
                                ],
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back,
                                      color: ColorTheme().iconColor))),
                        ),
                      )
                    ],
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              child: Card(
                  color: ColorTheme().cardColor,
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        title: Text('Change news language',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: ColorTheme().textColor)),
                                trailing: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),)
                      ),
                    ),
                  )),
            )
          ]),
        ));
  }
}
