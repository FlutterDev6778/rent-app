package com.example.rental

import android.annotation.TargetApi
import android.app.NotificationChannel
import android.app.NotificationManager
import android.net.Uri
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        //this.registerChannel()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
    }

    //@TargetApi(Build.VERSION_CODES.O)
    //private fun registerChannel(){
    //    val channel: NotificationChannel = NotificationChannel(
    //            getString(R.string.default_notification_channel_id),
    //            "CiggyGhar Delivery",
    //            NotificationManager.IMPORTANCE_HIGH
    //    ).also {

//            it.setSound(Uri.parse("android.resource://${packageName}/${R.raw.deduction}"), it.audioAttributes)
//        }
//        val manager:NotificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
//        manager.createNotificationChannel(channel)
//    }
}