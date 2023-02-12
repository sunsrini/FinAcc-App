import 'package:FinAcc/classes/ClsParty.dart';
import 'package:FinAcc/screens/auctionhistory.dart';
import 'package:FinAcc/screens/customerhistory.dart';
import 'package:FinAcc/screens/dashboard.dart';
import 'package:FinAcc/screens/daybook.dart';
import 'package:FinAcc/screens/loanhistory.dart';
import 'package:FinAcc/screens/pingeneration.dart';
import 'package:FinAcc/screens/receiptslist.dart';
import 'package:FinAcc/screens/repledgelist.dart';
import 'package:FinAcc/widgets/loanlist.dart';
import 'package:FinAcc/screens/loansummary.dart';
import 'package:FinAcc/screens/loansummarylist.dart';
import 'package:FinAcc/screens/login.dart';
import 'package:FinAcc/screens/partylist.dart';
import 'package:FinAcc/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:FinAcc/config/globals.dart' as Globals;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/':
        if (Globals.IsLoggedIn == true)
        {
          return Dashboard.route();
        } else {
          return Login.route();
        }

      case Dashboard.routeName:
        return Dashboard.route();

      case DayBook.routeName:
        return DayBook.route();

      case AuctionHistory.routeName:
        return AuctionHistory.route();

      case PartyList.routeName:
        return PartyList.route();

      case CustomerHistory.routeName:
      return CustomerHistory.route(routedParty: settings.arguments as ClsParty);

      case LoanSummary.routeName:
        return LoanSummary.route(RoutedLoanSno: settings.arguments as int);

      case LoanSummaryList.routeName:
        return LoanSummaryList.route();

      case LoanHistory.routeName:
        return LoanHistory.route();

      case RepledgeList.routeName:
      return RepledgeList.route();

      case ReceiptsList.routeName:
        return ReceiptsList.route();

      case PinGeneration.routeName:
        return PinGeneration.route();

      case Splash.routeName:
        return Splash.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: 'Error'),
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text("Routing Error"),
          ),
        ));
  }
}