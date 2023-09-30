import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';

// final allUsersProvider = StreamProvider.autoDispose((ref) {
// FirebaseFirestore.instance.collection('users').snapshots();
// return ref.watch(userRepositoryProvider).allUsers();
// return null;
// });

class MapPage extends HookConsumerWidget {
  final _default_init_position = const CameraPosition(
    target: LatLng(35.6625578, 139.6962623),
    zoom: 14,
  );

  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = ref.watch(allUsersProvider);

    useEffect(() {
      print(allUsers);
      return null;
    }, [allUsers]);

    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _default_init_position,
        onMapCreated: (GoogleMapController controller) {
          // _controller = controller;
        },
        markers: const <Marker>{},
        myLocationEnabled: true,
      ),
    );
  }

  Marker? _userMarker(LatLng position, String userId) {
    return null;
    // return Marker(
    //   markerId: MarkerId(userId),
    //   icon: user.matchingWith != currentUserId ? normalIcon : matchingIcon,
    //   position: LatLng(user.latitude!, user.longitude!),
    //   zIndex: user.matchingWith != currentUserId ? 1 : 2,
    // );
  }
}
