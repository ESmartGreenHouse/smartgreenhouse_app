import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/reports_picker/reports_picker.dart';
import 'package:smartgreenhouse_app/theme.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder<MaterialPageRoute<void>>(
      pageBuilder: (_, __, ___) => ReportsPage(),
      transitionDuration: Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(
        greenhouseRepository: context.repository<GreenhouseRepository>(),
      ),
      child: ResponsiveScaffold(
        title: Text('Reports'),
        drawer: AppDrawer(),
        trailing: LogoutButton(),
        endIcon:  Icons.biotech,
        endDrawer: ReportsPicker(),
        body: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoadSuccess) return PointsLineChart(state.measurement);
            if (state is ReportsLoadInProgress) return Column(children: [LinearProgressIndicator()]);
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
