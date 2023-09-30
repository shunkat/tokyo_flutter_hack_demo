import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokyo_flutter_hack_demo/common/styles/app_text_style.dart';
import 'package:tokyo_flutter_hack_demo/models/user/user.dart';
import 'package:tokyo_flutter_hack_demo/utils/AppPreference.dart';
import 'package:tokyo_flutter_hack_demo/utils/determinPosition.dart';
import 'package:tokyo_flutter_hack_demo/utils/uint8ListFromAsset.dart';

final canMarkerImageFutureProvider =
    FutureProvider<BitmapDescriptor>((ref) async {
  final value = await uint8ListFromAsset("assets/images/can.png", 150);
  return BitmapDescriptor.fromBytes(value);
});

final canMarkerImageProvider = StateProvider((ref) {
  final future = ref.watch(canMarkerImageFutureProvider);

  return future.when(
    data: (data) => data,
    loading: () => null,
    error: (e, s) {
      debugPrint("error");
      debugPrint(e.toString());
      return null;
    },
  );
});

final zoomLevelProvider = StateProvider<double>((ref) {
  return 14.0;
});

class MapPage extends HookConsumerWidget {
  static const initialZoomLevel = 14.0;
  final defaultInitPosition = const CameraPosition(
    target: LatLng(35.6625578, 139.6962623),
    zoom: initialZoomLevel,
  );

  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = ref.watch(allUsersProvider);
    final canMarkerImage = ref.watch(canMarkerImageProvider);
    final markers = useState<Set<Marker>>({});
    final mapController = useState<GoogleMapController?>(null);
    final currentPosition = useState<LatLng?>(null);
    final zoomLevelController = ref.read(zoomLevelProvider.notifier);

    useEffect(() {
      if (canMarkerImage == null) return null;
      if (allUsers == null) return null;

      markers.value =
          Set.from(allUsers.map((e) => _userMarker(e, canMarkerImage)));

      return null;
    }, [allUsers, canMarkerImage]);

    setCurrentPosition() {
      Geolocator.getCurrentPosition().then(
        (position) {
          if (position == null) return;

          currentPosition.value = LatLng(position.latitude, position.longitude);
        },
      );
    }

    useEffect(() {
      determinePosition().then((value) {
        setCurrentPosition();
      });

      final positionTimer =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        setCurrentPosition();
      });

      final syncTimer = Timer.periodic(
        const Duration(seconds: 10),
        (timer) async {
          if (currentPosition.value == null) return;

          FirebaseFirestore.instance
              .collection('users')
              .doc(ref.read(userIdProvider))
              .update({
            'latitude': currentPosition.value!.latitude,
            'longitude': currentPosition.value!.longitude,
          });
        },
      );

      return () {
        positionTimer.cancel();
        syncTimer.cancel();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム", style: AppTextStyle.noto16),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        color: const Color.fromARGB(255, 235, 235, 235),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.hardEdge,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: defaultInitPosition,
            onMapCreated: (GoogleMapController controller) {
              mapController.value = controller;
            },
            onCameraIdle: () {
              if (mapController.value == null) return;
              mapController.value!.getZoomLevel().then((value) {
                zoomLevelController.state = value;
              });
              return;
            },
            markers: markers.value,
            circles: {
              Circle(
                circleId: const CircleId("can"),
                center: currentPosition.value ?? defaultInitPosition.target,
                radius: 200,
                fillColor: const Color.fromRGBO(255, 236, 61, 0.5),
                strokeWidth: 0,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),
      ),
    );
  }

  Marker _userMarker(User user, BitmapDescriptor icon) {
    return Marker(
      markerId: MarkerId(user.id),
      icon: icon,
      position: LatLng(user.latitude, user.longitude),
      onTap: () {
        print("onTap");
        return;
      },
      // zIndex: user.matchingWith != currentUserId ? 1 : 2,
    );
  }
}
