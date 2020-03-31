import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state management
import 'package:app/providers/mainProvider.dart';

class SearchDropDown extends StatefulWidget {

  // props
  final List<String> dropdownItems;
  final List<String> dropdownValues;
  final String placeholder; 
  final String type;


  SearchDropDown({
    List<String> dropdownItems,
    List<String> dropdownValues,
    String placeholder,
    String type
  }) : this.dropdownItems = dropdownItems, this.dropdownValues = dropdownValues, this.placeholder = placeholder, this.type = type;

  @override
  _SearchDropDownState createState() => new _SearchDropDownState(
    dropdownItems,
    dropdownValues,
    placeholder,
    type
  );
}

class _SearchDropDownState extends State<SearchDropDown> {

  // get properties from constructor
  _SearchDropDownState(
    this.dropdownItems,
    this.dropdownValues,
    this.placeholder,
    this.type
  );
  final List<String> dropdownItems;
  final List<String> dropdownValues;
  final String placeholder;
  final String type;
 
  String _value;

  @override
  Widget build(BuildContext context) {
    // state
    final MainState mainState = Provider.of(context);

    return Center(
      child: 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          // margin bottom to search text field
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
          ),
          child: 
            DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                items: this.dropdownItems
                  .map((item) {
                    return DropdownMenuItem(
                          child: Text(item),
                          value: this.dropdownValues[this.dropdownItems.indexOf(item)]
                  );})
                  .toList(),
                onChanged: (String value) {
                  // set the state on change
                  setState(() {
                    _value = value;
                  });
                  this.type == 'level' ? mainState.setLevel(value) : mainState.setLanguage(value);
                },
                value: _value,
                hint: Text(this.placeholder),
              ),
            )
        )
    );
  }
}
