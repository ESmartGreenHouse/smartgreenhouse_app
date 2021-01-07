import 'package:flutter/material.dart';

class UidDialog extends StatelessWidget {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text('User'),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'UID',
                hintText: 'gC5rclGLjkclyB2ywo16rIWHlj53',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL', style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.of(context).pop(controller.value.text),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
