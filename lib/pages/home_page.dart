import 'package:expanse_tracker/components/expanse_summery.dart';
import 'package:expanse_tracker/components/expanse_tile.dart';
import 'package:expanse_tracker/data/expanse_data.dart';
import 'package:expanse_tracker/models/expanse_,item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpanseNameController = TextEditingController();
  final newExpanseDollarController = TextEditingController();
  final newExpanseCentsController = TextEditingController();

  void initState() {
    super.initState();

    Provider.of<ExpanseData>(context, listen: false).prepareData();
  }

  void addNewExpanse() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new expanse"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpanseNameController,
              decoration: InputDecoration(hintText: "Expanse Name"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpanseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Dollars"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: newExpanseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("Save"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void deleteExpanse(ExpanseItem expanse) {
    Provider.of<ExpanseData>(context, listen: false).deleteExpanse(expanse);
  }

  void save() {
    String amount =
        '${newExpanseDollarController.text}.${newExpanseCentsController.text}';
    ExpanseItem newExpanse = ExpanseItem(
        dateTime: DateTime.now(),
        amount: amount,
        name: newExpanseNameController.text);
    Provider.of<ExpanseData>(context, listen: false).addNewExpanse(newExpanse);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpanseNameController.clear();
    newExpanseDollarController.clear();
    newExpanseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpanseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpanse,
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
          ),
          body: ListView(
            children: [
              ExpanseSummery(startOfWeek: value.startOfWeekDay()),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpanseList().length,
                itemBuilder: (context, index) => ExpanseTile(
                  dateTime: value.getAllExpanseList()[index].dateTime,
                  amount: value.getAllExpanseList()[index].amount,
                  name: value.getAllExpanseList()[index].name,
                  deleteTapped: (p0) =>
                      deleteExpanse(value.getAllExpanseList()[index]),
                ),
              ),
            ],
          )),
    );
  }
}
