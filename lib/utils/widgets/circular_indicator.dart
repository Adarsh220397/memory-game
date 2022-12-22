import 'package:flutter/material.dart';
import 'package:memorygame/utils/constants/color_constants.dart';
import 'package:memorygame/utils/size_utils.dart';

class CircularIndicator extends StatefulWidget {
  const CircularIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<CircularIndicator> createState() => _CircularIndicatorState();
}

class _CircularIndicatorState extends State<CircularIndicator> {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return SizedBox(
      height: SizeUtils.get(20),
      width: SizeUtils.get(50),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: SizeUtils.get(2)),
              child: SizedBox(
                width: SizeUtils.get(5),
                height: SizeUtils.get(5),
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: ColorConstants.appColor,
                ),
              ),
            ),
            SizedBox(width: SizeUtils.get(2)),
            Padding(
              padding: EdgeInsets.all(SizeUtils.get(2)),
              child: SizedBox(
                child: Text('Please wait...',
                    style: themeData.textTheme.subtitle1,
                    textAlign: TextAlign.center),
              ),
            ),
          ]),
    );
  }
}
