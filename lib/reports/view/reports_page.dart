import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:responsive_scaffold/templates/layout/scaffold.dart';
import 'package:smartgreenhouse_app/logout/logout.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/sensors/sensors.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReportsPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SensorsCubit(
            greenhouseRepository: context.repository<GreenhouseRepository>(),
          )..load(),
        ),
        BlocProvider(
          create: (context) => ReportsCubit(
            greenhouseRepository: context.repository<GreenhouseRepository>(),
          ),
        )
      ],
      child: BlocListener<SensorsCubit, SensorsState>(
        listener: (context, state) {
          if (state is SensorsLoadSuccess) {
            if (state.selected != null) {
              context.bloc<ReportsCubit>().load(state.selected);
            }
          }
        },
        child: ResponsiveScaffold(
          title: Text('Reports'),
          drawer: AppDrawer(),
          trailing: LogoutButton(),
          endIcon:  Icons.biotech,
          endDrawer: Column(
            children: [
              ListTile(
                title: Text('Sensors', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Select a sensor to display its measurement'),
              ),
              Divider(),
              Flexible(child: SensorList()),
            ],
          ),
          body: PointsLineChart(),
        ),
      ),
    );
  }
}
