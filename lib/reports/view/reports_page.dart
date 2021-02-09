import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(
        greenhouseRepository: context.repository<GreenhouseRepository>(),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Reports'),
          actions: [
            IconButton(
              icon: Icon(Icons.biotech),
              onPressed: () =>_scaffoldKey.currentState.openEndDrawer(),
            ),
          ],
        ),
        drawer: AppDrawer(),
        endDrawer: Drawer(child: ReportsPicker()),
        body: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoadSuccess) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PointsLineChart(state.measurement),
              );
            }
            if (state is ReportsLoadInProgress) {
              return Column(children: [LinearProgressIndicator()]);
            }
            if (state is ReportsLoadFailure) {
              return Column(
                children: [
                  ListTile(
                    title: Text(state.message),
                    leading: Icon(Icons.error, color: GreenHouseColors.orange),
                  ),
                ],
              );
            }
            if (state is ReportsInitial) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Select a Measurement to load'),
                    leading: Icon(Icons.error, color: GreenHouseColors.orange),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _scaffoldKey.currentState.openEndDrawer(),
                  ),
                ],
              );
            }
            return Column(
              children: [
                ListTile(
                  title: Text('Unknown state'),
                  leading: Icon(Icons.error, color: GreenHouseColors.orange),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
