import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state management
import 'package:app/providers/mainProvider.dart';

class SearchDropDown extends StatelessWidget {

  // props
  final List<String> dropdownValues;
  final String placeholder; 
  final String type;

  // constructor
  SearchDropDown({
    List<String> dropdownValues,
    String placeholder,
    String type
  }) : this.dropdownValues = dropdownValues, this.placeholder = placeholder, this.type = type;

  String _value;

  @override
  Widget build(BuildContext context) {
    // state
    final MainState mainState = Provider.of(context);

    if (this.type == 'level') {
      _value = mainState.getLevel;
    } else {
      _value = mainState.getLanguage;
    }

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
                items: this.dropdownValues
                  .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                  .toList(),
                onChanged: (String value) {
                  // set the state on change
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
