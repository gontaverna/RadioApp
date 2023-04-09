import 'package:flutter/material.dart';

import 'styles/styles.dart';

class RadioAppBar extends StatelessWidget with PreferredSizeWidget {
  const RadioAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Styles.bkgColor,
        centerTitle: true,
        title: RichText(
          text: const TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'Radio',
              style: Styles.appTittle,
            ),
            TextSpan(
              text: 'App',
              style: Styles.appTittlePink,
            ),
          ]),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
