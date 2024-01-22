# Waterfly III

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=com.dreautall.waterflyiii"><img src=".playstore/en_badge_web_generic.png" width="200" /></a>
  <!--<a href="https://f-droid.org/en/packages/com.dreautall.waterflyiii/"><img src=".github/assets/fdroid_get-it-on.ong" width="200" /></a>-->
</p>

**Unofficial** Android App for [Firefly III](https://github.com/firefly-iii/firefly-iii), a free and open source personal finance manager.

The app design is heavily influenced by [Bluecoins](https://play.google.com/store/apps/details?id=com.rammigsoftware.bluecoins).

## Features

The app is still pretty much work in progress, but basic features already do work:

- General
  - Light & Dark mode, supports dynamic colors
  - Translation ready - [**help to translate via Crowdin**](https://crowdin.com/project/waterfly-iii)!
  - Listen to incoming notifications (e.g., from Google Pay or your banking app) and pre-fill transactions
  - Option to require fingerprint to open the app
- Dashboard
  - Five different charts charts for the current balance & recent history
  - Waterfall chart for net earnings in recent months
  - Budget overview for last 30 days
  - Upcoming bills
- Transactions
  - List transactions by date
  - Ability to filter the list by various fields
  - Add & edit transactions with autocomplete, including attachments and pictures, split transactions & multi currency support
- Balance Sheet
  - List individual account balances
- Piggy Banks
  - View piggy banks, sorted by category
  - Add/Remove money from piggy banks
- Accounts
  - List all asset/expense/revenue/liability accounts
  - Search for specific accounts
- Categories
  - View monthly transactions split up by category
  - Add, edit & delete categories

### Feature Status

The app does **not** try to replicate every single feature that the Webinterface has. Instead, it tries to be a good *companion* to access the most used functions on-the-go. More in-depth operations such as creating or deleting asset accounts, creating or modifying rules etc. are not planned.

If you are missing anything, feel free to open a [feature request](https://github.com/dreautall/waterfly-iii/issues/new/choose), or look at that other users [are requesting](https://github.com/dreautall/waterfly-iii/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement).

## Screenshots

*All made with a Google Pixel 5*

|                           Dashboard                           |                               Transactions                                |                        Balance Sheet                        |
| :-----------------------------------------------------------: | :-----------------------------------------------------------------------: | :---------------------------------------------------------: |
| <img src=".github/assets/screen_dashboard.png" width="250" /> | <img src=".github/assets/screen_transactions_overview.png" width="250" /> | <img src=".github/assets/screen_balance.png" width="250" /> |

|                        Transaction Edit                         |                           Split Transaction                           |                           Transaction Attachments                           |
| :-------------------------------------------------------------: | :-------------------------------------------------------------------: | :-------------------------------------------------------------------------: |
| <img src=".github/assets/screen_transaction.png" width="250" /> | <img src=".github/assets/screen_transaction_split.png" width="250" /> | <img src=".github/assets/screen_transaction_attachments.png" width="250" /> |

## Technology

The app is built using [Flutter](https://flutter.dev/), and tries to keep to the [Material 3](https://m3.material.io/) design guidelines. Additionally, I try to keep the app as "lean" as possible, **without any trackers** or unneeded dependency on external packages.

## Motivation

Having troubles with [Bluecoins](https://play.google.com/store/apps/details?id=com.rammigsoftware.bluecoins) syncing across devices and not always storing attachments online, I was looking for a self-hosted alternative and discovered [Firefly III](https://www.firefly-iii.org/). After a [quick script to migrate from Bluecoins to Firefly](https://github.com/dreautall/bluecoins-to-fireflyiii), the only thing left was to download an app to easy track expenses on-the-go… or so I thought.

Unfortunately, I discovered that the existing Android Apps for Firefly III are either outdated or very buggy and hardly maintained. Always wanting to use Flutter for something, I started to make my own app, modeling it after the Bluecoins app I used so far and its interface I really liked.
