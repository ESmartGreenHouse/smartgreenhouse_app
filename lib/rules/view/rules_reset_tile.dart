import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/rules/cubit/rules_cubit.dart';
import 'package:smartgreenhouse_app/theme.dart';

class RulesResetTile extends StatelessWidget {
  const RulesResetTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Reset threshold values of rules to default'),
      leading: FaIcon(FontAwesomeIcons.cogs, color: GreenHouseColors.black),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final result = await showDialog(context: context, builder: (_) => AlertDialog(
          title: Text('Reset rules'),
          content: Text('Are you sure you want to reset the rules? All your settings of thresholds will be lost.'),
          actions: [
            TextButton(
              child: Text('NO'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('YES'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ));

        if (result == true) {
          context.read<RulesCubit>().reset();
        }
      },
    );
  }
}
