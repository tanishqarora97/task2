import 'package:flutter/material.dart';
import 'package:task_1/constants.dart';
import 'package:task_1/model/api_model.dart';

class CustomCard extends StatelessWidget {
  final Tag data;
  CustomCard({this.data});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 210,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SelectableText(
                  data.displayName.toString(),
                  style: kDisplayNameTextStyle,
                ),
              ),
            ),
            SelectableText(data.meta == null ? '' : data.meta.toString(),
                style: kMetaDataTextStyle),
            SelectableText(data.description.toString()),
            SelectableText(
              'Spaces',
              style: kSpacesTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
