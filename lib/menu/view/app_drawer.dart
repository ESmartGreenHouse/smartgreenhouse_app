import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgreenhouse_app/app_router.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                ListTile(
                  title: Text(context.bloc<AuthenticationBloc>().state.user.email, style: TextStyle(color: Colors.white)),
                  trailing: LogoutButton(),
                ),
                Spacer(),
                Divider(color: Colors.white),
                ListTile(
                  trailing: BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      return Switch(
                        value: state.showAdvancedFeatures,
                        onChanged: (value) => context.bloc<MenuCubit>().showAdvancedFeatures(value),
                        activeColor: Colors.white,
                      );
                    },
                  ),
                  title: Text('Show advanced features?', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: GreenHouseColors.green,
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.home, color: GreenHouseColors.black),
            title: Text('Home'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
          ),
          BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              if (state.showAdvancedFeatures) {
                return ListTile(
                  leading: FaIcon(FontAwesomeIcons.microchip, color: GreenHouseColors.black),
                  title: Text('Particles'),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.particles, (route) => false)
                );
              }
              return Container();
            },
          ),
          BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              if (state.showAdvancedFeatures) {
                return ListTile(
                  leading: FaIcon(FontAwesomeIcons.clipboardList, color: GreenHouseColors.black),
                  title: Text('Reports'),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.reports, (route) => false),
                );
              }
              return Container();
            },
          ),
          BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              if (state.showAdvancedFeatures) {
                return ListTile(
                  leading: FaIcon(FontAwesomeIcons.cogs, color: GreenHouseColors.black),
                  title: Text('Rules'),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.rules, (route) => false),
                );
              }
              return Container();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: GreenHouseColors.black),
            title: Text('Settings'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.settings, (route) => false),
          ),
        ],
      ),
    );
  }
}
