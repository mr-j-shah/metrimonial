import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:flutter/material.dart';

class GridSquareCard extends StatelessWidget {
  final Widget onpressed;
  final icon;
  final isSmallScreen;
  final text;

  GridSquareCard({
    this.onpressed,
    this.icon,
    this.isSmallScreen,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => onpressed),
        );
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyTheme.app_accent_color,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
                child: IconButton(
              icon: Image.asset(
                'assets/icon/${icon}',
                width: 16,
                height: 16,
              ),
              // color: MyTheme.white,
            )
                // child: icon,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 90,
            child: Text(text,
                style: isSmallScreen
                    ? Styles.regular_arsenic_11.copyWith()
                    : Styles.regular_arsenic_12,
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
