import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpanseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;
  ExpanseTile({
    super.key,
    required this.dateTime,
    required this.amount,
    required this.name,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteTapped,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(6),
        )
      ]),
      child: ListTile(
        title: Text(name),
        subtitle:
            Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        trailing: Text('\$' + amount),
      ),
    );
  }
}
