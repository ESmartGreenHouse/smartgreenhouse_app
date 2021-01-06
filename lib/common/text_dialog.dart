import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  final String title;
  final String label;
  final String hint;
  final String initalValue;

  TextDialog({
    @required this.title,
    this.label = 'Value',
    this.hint = 'Example',
    this.initalValue,
  });

  @override
  _TextDialogState createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {

  final _controller = TextEditingController();
  String error;

  @override
  void initState() {
    if (widget.initalValue != null) _controller.text = widget.initalValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _submit() {
      if (_controller.value.text.isNotEmpty) {
        Navigator.of(context).pop(_controller.value.text);
      } else {
        error = 'Please enter value';
      }
    }

    return SimpleDialog(
      title: Text(widget.title),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              errorText: error,
            ),
            onSubmitted: (_) => _submit,
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
                onPressed: () => _submit(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
