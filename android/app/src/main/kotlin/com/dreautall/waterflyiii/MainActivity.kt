package com.dreautall.waterflyiii

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Build
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
			when (call.method) {
				"openNotificationListenerSettings" -> {
					result.success(startSettingsActivity(
						Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
					))
				}
				"supportsRuntimeNotificationPermission" -> {
					result.success(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
				}
				"openAppNotificationSettings" -> {
					val notificationSettings = Intent(
						Settings.ACTION_APP_NOTIFICATION_SETTINGS
					).putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
					if (startSettingsActivity(notificationSettings)) {
						result.success(true)
					} else {
						result.success(startSettingsActivity(
							Intent(
								Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
								Uri.parse("package:$packageName")
							)
						))
					}
				}
				else -> result.notImplemented()
			}
		}
	}

	private fun startSettingsActivity(intent: Intent): Boolean {
		return try {
			startActivity(intent)
			true
		} catch (_: ActivityNotFoundException) {
			false
		}
	}
}
