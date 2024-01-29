import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeeazy_medical/constants/colors.dart';
import 'package:lifeeazy_medical/constants/strings.dart';
import 'package:lifeeazy_medical/constants/styles.dart';

class SearchView extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? searchText;

  SearchView({this.onChanged, this.searchText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: kToolbarHeight,
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: baseColor,
                  size: 24,
                ),
              ),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nearestScope;
                      },
                      onSaved: (value) {},
                      validator: (value) {},
                      onChanged: (value) {
                        this.onChanged!(value);
                      },
                      style: mediumTextStyle,
                      decoration: InputDecoration(
                        labelStyle: textFieldsHintTextStyle,
                        hintStyle: textFieldsHintTextStyle,
                        hintText: search,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
