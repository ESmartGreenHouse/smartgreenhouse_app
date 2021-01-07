import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/theme.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: CircularProgressIndicator(
            strokeWidth: 10.0,
            valueColor: AlwaysStoppedAnimation(GreenHouseColors.green),
          ),
        ),
      ),
    );
  }
}
