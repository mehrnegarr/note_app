import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_application/widget/task_type_item.dart';
import 'package:note_application/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selectedTaskTypeitem = 0;

  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban1.hasFocus
                          ? const Color(0xff18DAA3)
                          : const Color(0xffC5C5C5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerTaskSubTitle,
                  maxLines: 2,
                  focusNode: negahban2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban2.hasFocus
                          ? const Color(0xff18DAA3)
                          : const Color(0xffC5C5C5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomHourPicker(
                title: 'زمان تسک رو انتخاب کن',
                negativeButtonText: 'حذف کن',
                positiveButtonText: 'انتخاب زمان',
                elevation: 2,
                titleStyle: const TextStyle(
                  color: Color(0xff18DAA3),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                negativeButtonStyle: const TextStyle(
                  color: Color.fromARGB(255, 218, 66, 24),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                positiveButtonStyle: const TextStyle(
                  color: Color(0xff18DAA3),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                onPositivePressed: (context, time) {
                  _time = time;
                },
                onNegativePressed: (context) {},
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getTaskTypeList().length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTaskTypeitem = index;
                      });
                    },
                    child: TaskTypeItemList(
                      taskType: getTaskTypeList()[index],
                      index: index,
                      selectedItemList: _selectedTaskTypeitem,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                String taskTitle = controllerTaskTitle.text;
                String taskSubTitle = controllerTaskSubTitle.text;
                addTask(taskTitle, taskSubTitle);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff18DAA3),
                minimumSize: const Size(200, 48),
              ),
              child: const Text(
                'اضافه کردن تسک',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(
      title: taskTitle,
      subTitle: taskSubTitle,
      time: _time!,
      taskType: getTaskTypeList()[_selectedTaskTypeitem],
    );
    box.add(task);
  }
}
