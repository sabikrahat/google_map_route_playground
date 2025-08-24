import 'package:flutter/material.dart';
import 'package:google_map_route_playground/src/features/home/view/map_view.dart';

import '../../../core/shared/riverpod/helper.dart';
import 'components/location_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String name = 'home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<void> _permissionRequests;

  @override
  void initState() {
    super.initState();
    // Initialize the _permissionRequests Future to handle permissions
    _permissionRequests = _handlePermissionRequests();
  }

  Future<void> _handlePermissionRequests() async => await requestLocationDialog(context);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _permissionRequests,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: KLoading());
        }
        if (snapshot.hasError) return Scaffold(body: KError(snapshot.error));
        return MapView();
      },
    );
  }
}
