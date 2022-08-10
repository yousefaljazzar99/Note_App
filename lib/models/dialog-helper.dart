import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes/models/my-utils.dart';

class DialogHelper {
  static void showColorDialog(
      {BuildContext context,
      Color pickerColor,
      ValueChanged<Color> onColorChanged}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select colors'.tr()),
          content: SizedBox(
            height: 210,
            child: BlockPicker(
              availableColors: [
                Theme.of(context).canvasColor,
                MyUtils.getColorFromHexCode('#F2D7D5'),
                MyUtils.getColorFromHexCode('#FADBD8'),
                MyUtils.getColorFromHexCode('#EBDEF0'),
                MyUtils.getColorFromHexCode('#D4E6F1'),
                MyUtils.getColorFromHexCode('#D1F2EB'),
                MyUtils.getColorFromHexCode('#D5F5E3'),
                MyUtils.getColorFromHexCode('#FCF3CF'),
                MyUtils.getColorFromHexCode('#F6DDCC'),
                MyUtils.getColorFromHexCode('#F1948A'),
                MyUtils.getColorFromHexCode('#AF7AC5'),
                MyUtils.getColorFromHexCode('#5DADE2'),
                MyUtils.getColorFromHexCode('#1321E0'),
                MyUtils.getColorFromHexCode('#FFFFFF'),
                MyUtils.getColorFromHexCode('#F28B81'),
                MyUtils.getColorFromHexCode('#F7BD02'),
                MyUtils.getColorFromHexCode('#FBF476'),
                MyUtils.getColorFromHexCode('#CDFF90'),
                MyUtils.getColorFromHexCode('#A7FEEB'),
                MyUtils.getColorFromHexCode('#CBF0F8'),
                MyUtils.getColorFromHexCode('#AFCBFA'),
                MyUtils.getColorFromHexCode('#D7AEFC'),
                MyUtils.getColorFromHexCode('#FBCFE9'),
                MyUtils.getColorFromHexCode('#E6C9A9'),
                MyUtils.getColorFromHexCode('#E9EAEE'),
              ],
              pickerColor: pickerColor == null
                  ? Theme.of(context).canvasColor
                  : pickerColor,
              onColorChanged: onColorChanged,
            ),
          ),
        );
      },
    );
  }

  static void showConfirm({
    BuildContext context,
    VoidCallback onOKPressed,
    String title,
    String message,
  }) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel".tr()),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK".tr()),
      onPressed: onOKPressed,
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }
}
