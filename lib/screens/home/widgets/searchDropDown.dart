import 'package:flutter/material.dart';

class SearchDropDown extends StatefulWidget {

  // props
  final List<String> dropdownValues;
  final String placeholder; 

  // constructor
  const SearchDropDown({
    List<String> dropdownValues,
    String placeholder
  }) : this.dropdownValues = dropdownValues, this.placeholder = placeholder;

  // create state
  @override
  _SearchDropDownState createState() => new _SearchDropDownState(dropdownValues, placeholder);
}

class _SearchDropDownState extends State<SearchDropDown> {

  // get properties from constructor
  _SearchDropDownState(
    this.dropdownValues,
    this.placeholder
  );
  final List<String> dropdownValues;
  final String placeholder;

  // selected value from the dropdown menu
  String _value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
          ),
          child: 
            DropdownButton<String>(
              items: this.dropdownValues
                .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                .toList(),
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
              },
              value: _value,
              hint: Text(this.placeholder),
          ),
        )
    );
  }
}
