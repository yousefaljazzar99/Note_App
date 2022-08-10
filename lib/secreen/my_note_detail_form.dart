import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyNoteDetailForm extends Form {
  MyNoteDetailForm({
    GlobalKey<FormState> key,
    TextEditingController titleController,
    TextEditingController contentController,
    bool readOnly = false,
  }) : super(
            key: key,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    readOnly: readOnly,
                    controller: titleController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Add Title".tr(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the title'.tr();
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                        readOnly: readOnly,
                        controller: contentController,
                        decoration: InputDecoration(
                          hintText: "Add Content".tr(),
                          hintStyle: TextStyle(color: Colors.black87),
                        ),
                        maxLines: 30,
                        keyboardType: TextInputType.multiline),
                  ),
                ],
              ),
            ));
}
