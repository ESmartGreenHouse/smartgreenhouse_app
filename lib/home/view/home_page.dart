import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;

    return ResponsiveScaffold(
      title: Text('Home'),
      drawer: AppDrawer(),
      endIcon: Icons.help,
      endDrawer: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Notifications'),
          ),
          Divider(),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
          ListTile(
            title: Text('Nachricht'),
            subtitle: Text(DateTime.now().toIso8601String()),
          ),
        ],
      ),
      trailing: LogoutButton(),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? 'Test', style: textTheme.headline5),
            const SizedBox(height: 4.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      ),
    );
  }
}
