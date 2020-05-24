import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/providers/bus/favorite_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/nearby_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/search_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/location_provider.dart';
import 'package:lta_datamall_flutter/providers/observer_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'models/bus_stops/bus_stop_model.dart';
import 'models/user_location.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    @required this.busStopModelList,
  });

  final List<BusStopModel> busStopModelList;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<ObserverProvider>(
          create: (_) => ObserverProvider(),
        ),
        ChangeNotifierProvider<NearbyBusStopsProvider>(
          create: (_) => NearbyBusStopsProvider(allBusStops: busStopModelList),
        ),
        ChangeNotifierProvider<FavoriteBusStopsProvider>(
          create: (_) =>
              FavoriteBusStopsProvider(allBusStops: busStopModelList),
        ),
        ChangeNotifierProvider<SearchBusStopsProvider>(
          create: (_) => SearchBusStopsProvider(allBusStops: busStopModelList),
        ),
        StreamProvider<UserLocation>(
          create: (_) => LocationProvider().locationStream,
        )
      ],
      child: Consumer<ObserverProvider>(
        builder: (
          BuildContext context,
          ObserverProvider observer,
          _,
        ) {
          return MaterialApp(
            builder: ExtendedNavigator<Router>(
              initialRoute: Routes.mainBusScreenRoute,
              router: Router(),
              observers: <NavigatorObserver>[
                observer.getAnalyticsObserver(),
              ],
            ),
            title: 'SG Land Transport',
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
          );
        },
      ),
    );
  }
}