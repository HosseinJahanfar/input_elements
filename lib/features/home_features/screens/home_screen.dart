import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:input_elements/constant/shape/border_radius.dart';
import 'package:input_elements/constant/shape/media_query.dart';
import 'package:input_elements/constant/theme/colors.dart';
import 'package:input_elements/features/home_features/widget/app_bar_widget.dart';
import 'package:input_elements/features/home_features/widget/carousel.dart';
import 'package:input_elements/features/home_features/widget/textformfield_widget.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../../../constant/responsive.dart';
import '../../light_features/light_flash.dart';
import '../../speech_features/speech.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textPhoneController = TextEditingController();
  bool isDone = false;
  bool? isChecked = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  // Initial Selected Value dropdown
  String dropdownValue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  //!Step
  int currentStep = 0;

  //!CupertinoSwitch
  bool _switchValue = false;
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                const CarouselSliderWidget(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormFieldMobileWidget(
                    labelText: 'شماره موبایل',
                    icon: const Icon(Icons.phone_android_outlined),
                    textInputAction: TextInputAction.done,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: textPhoneController,
                  ),
                ),
                checkBox(),
                SizedBox(
                  height: 10.sp,
                ),
                radioListTile(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary2Color,
                        fixedSize: Size(getWidth(context, 0.5),
                            Responsive.isTablet(context) ? 60 : 45)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: greenSnackBar,
                        content: Text(
                          "اسنک بار با موفیت نمایش داده شد",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      ));
                    },
                    child: const Text(
                      "اسنک بار",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10.sp,
                ),
                //!DropdownButton
                DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),

                //!Step
                stepper(),
                spinBox(),
                SizedBox(
                  height: 15.sp,
                ),
                cupertinoSwitch(),
                SizedBox(
                  height: 15.sp,
                ),
                textButtonIcon(),
                SizedBox(
                  height: 15.sp,
                ),
                outlinedButtonIcon(),
                SizedBox(
                  height: 15.sp,
                ),

                ElevatedButton(
                  onPressed: () {
                    //_toggleRecording();
                  },
                  child:
                      Text(isRecording ? 'Stop Recording' : 'Start Recording'),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LightFlash(),
                          ));
                    },
                    child: const Text("LightFlash")),
                SizedBox(
                  height: 10.sp,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Speech(),
                          ));
                    },
                    child: const Text("Speech")),

                //!Button_Camera
                ElevatedButton(
                  onPressed: () {
                    _openCamera(context);
                  },
                  child: const Text('گرفتن عکس'),
                ),
                SizedBox(
                  height: 10.sp,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primary2Color,
          child: const Icon(Icons.camera),
        ),
      ),
    );
  }

//!outlinedButtonIcon
  OutlinedButton outlinedButtonIcon() {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(backgroundColor: Colors.transparent),
        onPressed: () {},
        icon: const Icon(Icons.monitor_heart),
        label: const Text(
          "OutlinedButton",
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

//!textButtonIcon
  TextButton textButtonIcon() {
    return TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.heart_broken_sharp),
        label: const Text(
          "TextButtonIcon",
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

//!cupertinoSwitch
  CupertinoSwitch cupertinoSwitch() {
    return CupertinoSwitch(
      value: _switchValue,
      onChanged: (bool value) {
        setState(() {
          _switchValue = value; // Update the state based on the new value
        });
      },
      activeColor: greenSnackBar,
    );
  }

//!spinBox
  Container spinBox() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: getBorderRadiusFunc(20)),
      child: WheelChooser.integer(
        onValueChanged: (s) => debugPrint(s.toString()),
        maxValue: 18,
        minValue: 1,
        initValue: 5,
        unSelectTextStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }

//!stepper
  Stepper stepper() {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      steps: [
        Step(
            isActive: currentStep == 0,
            title: const Text("Step 1"),
            content: const Text(
              'information for step1',
              style: TextStyle(color: Colors.redAccent),
            )),
        Step(
            isActive: currentStep == 1,
            title: const Text("Step 2"),
            content: const Text(
              'information for step2',
              style: TextStyle(color: Colors.redAccent),
            )),
        Step(
            isActive: currentStep == 2,
            title: const Text("Step 3"),
            content: const Text(
              'information for step3',
              style: TextStyle(color: Colors.redAccent),
            )),
      ],
      currentStep: currentStep,
      onStepTapped: (value) {
        setState(() {
          currentStep = value;
        });
      },
      onStepContinue: () {
        if (currentStep != 2) {
          setState(() {
            currentStep += 1;
          });
        }
      },
      onStepCancel: () {
        setState(() {
          currentStep -= 1;
        });
      },
    );
  }

//!checkBox
  Row checkBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
        )
      ],
    );
  }

//!radioListTile
  Row radioListTile() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            // subtitle:  Text('برای زمانی که این کار انجام نشده'),
            title: const Text('انجام نشده'),
            value: false,
            groupValue: isDone,
            onChanged: (value) {
              setState(() {
                isDone = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: const Text('انجام شده'),
            value: true,
            groupValue: isDone,
            onChanged: (value) {
              setState(() {
                isDone = value!;
              });
            },
          ),
        ),
      ],
    );
  }

//!OpenCamera
  Future<void> _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('عکس گرفته شده'),
          content: Image.file(File(pickedFile.path)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('بستن'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'عملیات لغو شد یا مشکلی رخ داد.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
