import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- Text Widget refactored ---
class TextForm extends StatelessWidget {
  TextForm({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      //tag email
      text,
      style: TextStyle(
        color: Color(0xFF6848AE),
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// --- Simple Radio refactored ---
class SingleCustomRadio extends StatefulWidget {

  List<String> namedButton;
  final Function(int) onAnswer;

  SingleCustomRadio({ Key key, this.namedButton, this.onAnswer}): super(key: key);
  @override
  _SingleCustomRadioState createState() => _SingleCustomRadioState();
}
class _SingleCustomRadioState extends State<SingleCustomRadio> {
  int groupValue;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (int index = 0; index < widget.namedButton.length; ++index)
          RadioListTile<int>(
            title: new Text(
              widget.namedButton[index],
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            value: index,
            groupValue: groupValue,
            onChanged: (int value) {
                widget.onAnswer(groupValue = value);},
            activeColor: Color(0xFF6848AE),
          ),
      ],
    );
  }
}

// --- One Radio refactored ---
class ACustomRadio extends StatefulWidget {

  String namedButton;
  int index;
  int groupValue;
  final Function(int) onAnswer;

  ACustomRadio({ Key key, this.namedButton, this.onAnswer, this.index, this.groupValue}): super(key: key);
  @override
  _ACustomRadioState createState() => _ACustomRadioState();
}
class _ACustomRadioState extends State<ACustomRadio> {


  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      title: new Text(
        widget.namedButton,
        style: TextStyle(color: Colors.black54, fontSize: 16),
      ),
      value: widget.index,
      groupValue: widget.groupValue,
      onChanged: (int value) {
        widget.onAnswer(widget.groupValue = value);},
      activeColor: Color(0xFF6848AE),
    );
  }
}

// --- Simple Checkbox refactored ---
class CustomCheckbox extends StatefulWidget {
  Function(bool) onAnswer;
  final String textBox;
  CustomCheckbox ({ Key key, this.textBox, this.onAnswer}): super(key: key);
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}
class _CustomCheckboxState extends State<CustomCheckbox> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.textBox,style: TextStyle(color: Colors.black54, fontSize: 16),),
      activeColor: Color(0xFF6848AE),
      value: checkBoxValue,
      onChanged: (bool value) {
          widget.onAnswer(checkBoxValue = value);
      },
    );
  }
}

class CustomForm extends StatefulWidget {
  Function(String) onChanged;
  Function(String) validator;
  TextInputType  keyboardType;
  String initialValue;
  List<TextInputFormatter> inputFormatters;
  final bool obscureText, enabled;
  final String hintText;
  CustomForm ({ Key key, this.enabled, this.initialValue, this.hintText, this.onChanged, this.keyboardType, this.validator, this.obscureText, this.inputFormatters}): super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}
class _CustomFormState extends State<CustomForm> {
  String formValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //form field name
      cursorColor: Color(0xFF6848AE),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF6848AE),
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.all(8.0),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
          fontSize: 14.0,
        ),
      ),
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      validator:widget.validator,
      obscureText: widget.obscureText,
      inputFormatters: widget.inputFormatters,
      onChanged: (val) {
        widget.onChanged(formValue = val);
      },
    );
  }
}