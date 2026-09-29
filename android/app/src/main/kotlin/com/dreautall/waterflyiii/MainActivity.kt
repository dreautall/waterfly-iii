package com.dreautall.waterflyiii

import android.content.ActivityNotFoundException
import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)
		MethodChannel(
			flutterEngine.dartExecutor.binaryMessenger,
			"waterflyiii/notification_apps"
		).setMethodCallHandler { call, result ->
			if (call.method == "manifestQueryPackages") {
				result.success(
					BuildConfig.NOTIFICATION_QUERY_PACKAGES
						.split(",")
						.filter { it.isNotBlank() }
				)
			} else {
				result.notImplemented()
			}
		}
		MethodChannel(
			flutterEngine.dartExecutor.binaryMessenger,
			"waterflyiii/notification_settings"
		).setMethodCallHandler { call, result ->
			if (call.method == "openNotificationListenerSettings") {
				try {
					startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
					result.success(true)
				} catch (_: ActivityNotFoundException) {
					result.success(false)
				}
			} else {
				result.notImplemented()
			}
		}
	}
}
