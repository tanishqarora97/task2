import 'package:flutter/material.dart';
import 'package:task_1/model/api_model.dart';
import 'package:task_1/repositories/api_repo.dart';
import 'package:task_1/widgets/custom_card.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool _toggleScreen = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _displayname = TextEditingController();
  final TextEditingController _meta = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  List<Tag> localDataList = [];
  @override
  void dispose() {
    _meta.dispose();
    _desc.dispose();
    _displayname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_toggleScreen ? Icons.arrow_back : Icons.add),
        onPressed: () {
          setState(() {
            _toggleScreen = !_toggleScreen;
          });
        },
      ),
      body: _toggleScreen
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(18),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _displayname,
                          validator: (data) {
                            if (data.length < 1) {
                              return 'Enter Value';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter display name'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _meta,
                          validator: (data) {
                            if (data.length < 1) {
                              return 'Enter Value';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter meta data'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: _desc,
                            validator: (data) {
                              if (data.length < 1) {
                                return 'Enter Value';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter description data',
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () async {
                            var isValid = _formKey.currentState.validate();
                            if (!isValid) {
                              return;
                            } else {
                              var data = Tag(
                                  displayName: _displayname.text,
                                  description: _desc.text,
                                  meta: _meta.text);
                              localDataList.add(data);
                              _meta.clear();
                              _desc.clear();
                              _displayname.clear();
                              setState(() {
                                _toggleScreen = !_toggleScreen;
                              });
                            }
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              ),
            )
          : (localDataList.isEmpty)
              ? Center(
                  child: Text('Add The data first'),
                )
              : ListView.builder(
                  itemCount: localDataList.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      data: Tag(
                        displayName: localDataList[index].displayName,
                        description: localDataList[index].description,
                        meta: localDataList[index].meta,
                      ),
                    );
                  }),
    );
  }
}
