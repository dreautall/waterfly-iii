# FAQ

## Base Functionality

**Q: How can I copy an existing transaction? (Alternatively: Use a transaction template)**

A: Long press on any transaction and select "Duplicate" from the context menu. It will open the new
transaction dialogue with all information pre-filled, only the date & time will be set to the
current time. You can modify any fields before saving it.


**Q: How do I use a custom (self-signed) SSL certificate?**

A: With the current technical implementation, the app uses the Android certificate store. You can
create your own CA (Certificate Authority) to create your self-signed certificates and add the
CA's (long-living) certificate into the Android Certificate Store. Then, any certificates signed by
your CA will be trusted by the app. However, due to technical limitations, I cannot implement an "
bypass certificate validation" option (or something similar). You can find a more technical
answer [here](https://github.com/dreautall/waterfly-iii/issues/77#issuecomment-2143724258)
and [here](https://github.com/dreautall/waterfly-iii/issues/418#issuecomment-2237184561).


**Q: How do I report bugs?**

A: If you encounter a bug, please help me fix it by providing a detailed report:

1. **Enable debug logs:** Go to the Settings page and click on the version number. This will show an
   option to enable debug logs.
2. **Reproduce the bug:** Perform the actions that cause the bug to occur.
3. **Send the log:** Go back to the Settings page and send the log. This will open your email app
   with my email address pre-filled and the log attached (it's a simple text file).

* **Alternative: GitHub issue**: You can also create
  a [new GitHub issue](https://github.com/dreautall/waterfly-iii/issues/new) and upload the log
  there. The log may contain sensitive information. If you upload the log to GitHub, please make
  sure to remove or redact any sensitive data before sharing it.


**Q: How do I request new features?**

A: I welcome your suggestions for new features! Either open
a [new GitHub issue](https://github.com/dreautall/waterfly-iii/issues/new) or send me a mail. You
can find the mail on
the [Play Store page](https://play.google.com/store/apps/details?id=com.dreautall.waterflyiii).



## Notification Listener

**Q: How does the notification listener service work?**

A: When enabled, the app will monitor incoming notifications containing a monetary value (something
like "*$12.34*"). If it detects such a notification, you can add the app in the settings. Then,
whenever you receive a notification from that app, Waterfly III will offer you the option to add a
new transaction.


**Q: I enabled the notification listener, but my app is not listed!**

A: After enabling, you need to receive at least one valid notification from your app for it to show
up. A valid notification is one that contains a monetary value (something like "*$12.34*"). If it
still doesn't show up, there are a couple of reasons why:

* Waterfly III needs to be pre-configured to listen to specific apps. Due to Android restrictions, I
  need to specify all potential apps in my code. Please mail me the missing app name and Play Store
  link. You can find my email address in the app (when you click on "Add App").
* Starting with Android 15, Google implemented a feature to prevent apps from accessing one-time
  codes (like verification codes) in notifications. Unfortunately, that implementation is very
  basic. Most notably, *AMEX* generates notifications like "*You paid $12.34 with your card ending
  in \*\*12345*". Google thinks "12345" is a one-time code and hides the notification from the app.
    * **For advanced users**: You can allow Waterfly III to access notifications containing
      sensitive information via the adb shell command
      `appops set com.dreautall.waterflyiii RECEIVE_SENSITIVE_NOTIFICATIONS allow`. Note that I will
      not provide any support for this.
    * **For other users**: You can achieve the same by disabling the "Enhanced Notifications" in the
      Android settings. I'm not sure what the potential drawbacks of this are, but it will disable
      Android-suggested replies.


**Q: The app selects the wrong currency!**

A: Most of the time, the issue is from currencies that also use the `$` (Dollar) sign, for example Austrian Dollar (`A$`). The app checks the notification for an exact match of the currency, so a transaction with "You paid $ 12.34" gets matched to the (US-)Dollar. To fix this, you can change the currency settings in Firefly III, for example make the sign of the US-Dollar to `US$`, and change Austrian Dollar from `A$` to just `$`. This way, notifications with just `$` will get matched to Austrian Dollar.



## Misc

**Q: Any plans to make money with the app?**

A: No, there are no plans to monetize the app. There will be no ads, no paid features, and no price.
I want to keep the app free for everyone. If you want to thank me, you can do so
via [GitHub Sponsors](https://github.com/sponsors/dreautall), but I do not expect it.


**Q: Where is the privacy policy?**

A: The app has a minimal privacy policy. The app only sends data to the server you specify during
setup. Google may collect crash reports if you install the app via the Play Store that are forwarded
to me. Google requires a Privacy Policy for the Play Store listing, which you can
find [here](https://github.com/dreautall/waterfly-iii/blob/master/.playstore/privacy-policy.md).


**Q: Why can't I find the app on F-Droid?**

A: I honestly don't know. Opening the request to include the app into the F-Droid store was made
pretty
early ([GitHub issue](https://github.com/dreautall/waterfly-iii/issues/2), [F-Droid issue](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/12959)).
There was quite a bit of back-and-forth on the F-Droid issue, but not really any solution or path
for me to work towards.
You can however add *IzzyOnDroid*s F-Droid store
and [find the app there](https://apt.izzysoft.de/fdroid/index/apk/com.dreautall.waterflyiii)
