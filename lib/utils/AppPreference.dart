import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userIdPath = "userId";

final sharedPreferencesProvider =
    FutureProvider((_) => SharedPreferences.getInstance());

class AppPreference {
  setUserId(String userId) async {
    final preference = await SharedPreferences.getInstance();
    preference.setString(userIdPath, userId);
  }
}

final userIdProvider = StateProvider((ref) {
  return ref.watch(sharedPreferencesProvider).when(
      data: (data) {
        return data.getString(userIdPath);
      },
      loading: () => null,
      error: (error, _) {
        debugPrint(error.toString());
        return null;
      });
});
