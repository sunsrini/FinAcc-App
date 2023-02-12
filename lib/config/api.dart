import 'dart:convert';
import 'dart:io';
import 'package:FinAcc/classes/ClsAuctionList.dart';
import 'package:FinAcc/classes/ClsClientInfo.dart';
import 'package:FinAcc/classes/ClsCustomerHistory.dart';
import 'package:FinAcc/classes/ClsDaybook.dart';
import 'package:FinAcc/classes/ClsLoan.dart';
import 'package:FinAcc/classes/ClsLoanSummary.dart';

import 'package:FinAcc/classes/ClsParty.dart';
import 'package:FinAcc/classes/ClsReceipts.dart';
import 'package:FinAcc/classes/ClsRepledge.dart';
import 'package:FinAcc/classes/ClsStatus.dart';
import 'package:FinAcc/classes/ClsTransactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'globals.dart' as Globals;

class Api {

  static Future<bool> getUser(String User_Name, String User_Password,
      BuildContext context) async {
    OverlayLoadingProgress.start(context);
    final queryParameters = {
      'data': '{"DbName" : "", "User_Name" : "$User_Name", "User_Password" : "$User_Password"}',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getUser',
        queryParameters);


    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();

    if (body['queryStatus']== 0){
      return false;
    }
    else
      {
        Globals.IsLoggedIn = true;
        Globals.LoggedUser = User_Name;

        Globals.Comp_Name = body['apiData'][0]['Comp_Name'];
        Globals.DbName = body['apiData'][0]['DbName'];

        Globals.ClientInfo = body['ClientInfo'].map<ClsClientInfo>(ClsClientInfo.fromJson).toList();
        return true;
      }
  }

  static Future<List<ClsStatus>> getStatusCard(int StatusType, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"StatusType" : "$StatusType", "DbName" : "$DbName" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getStatusCard',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsStatus>(ClsStatus.fromJson).toList();
  }

  static Future<List<ClsTransactions>> getRecentTransactions(BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getRecentTransactions',
        queryParameters);
    //print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsTransactions>(ClsTransactions.fromJson).toList();
  }

  static Future<List> getDayBook(DateTime tDate, BuildContext context) async {

    tDate = DateUtils.dateOnly(tDate);

    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "Date" : "$tDate" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getDayBook',
        queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return [body['apiData'].map<ClsDayBook>(ClsDayBook.fromJson).toList(), body['OpenBal'], body['CloseBal']];
  }

  static Future<List<ClsAuctionList>> getAuctionHistory(DateTime AsOn, BuildContext context) async {
    AsOn = DateUtils.dateOnly(AsOn);

    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "AsOn" : "$AsOn" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getAuctionHistory',
        queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsAuctionList>(ClsAuctionList.fromJson).toList();
  }

  static Future<List<ClsParty>> getPartyList( int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    print ("came");
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getPartyList',
        queryParameters);

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsParty>(ClsParty.fromJson).toList();
  }

  static Future<List<ClsParty>> getFilteredPartyList( String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    print ("came");
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getFilteredPartyList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsParty>(ClsParty.fromJson).toList();
  }

  static Future<List<ClsLoan>> getLoansList( int LnStatus, int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters =
    {
      'data': '{"DbName" : "$DbName", "LnStatus" : "$LnStatus", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getLoansList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsLoan>(ClsLoan.fromJson).toList();
  }

  static Future<List<ClsLoan>> getFilteredLoansList(int LnStatus, String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    print ("came");
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName","LnStatus" : "$LnStatus", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getFilteredLoansList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsLoan>(ClsLoan.fromJson).toList();
  }

  static Future<List<ClsCustomerHistory>> getCustomerHistory( int PartySno, BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "PartySno" : "$PartySno" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getCustomerHistory',
        queryParameters);
    
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsCustomerHistory>(ClsCustomerHistory.fromJson).toList();
  }

  static Future<List> getLoanSummary( int LoanSno, BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "LoanSno" : "$LoanSno" }',
    };

    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getLoanSummary',
        queryParameters);

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return [body['apiData'].map<ClsLoanSummary>(ClsLoanSummary.fromJson).toList(),body['LoanTrans'].toList()];
  }

  static Future<List<ClsRepledge>> getRepledgeList( int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters =
    {
      'data': '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getRepledgeList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsRepledge>(ClsRepledge.fromJson).toList();
  }

  static Future<List<ClsRepledge>> getFilteredRepledgeList(String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    print ("came");
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getFilteredRepledgeList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsRepledge>(ClsRepledge.fromJson).toList();
  }

  static Future<List<ClsReceipts>> getReceiptsList( int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters =
    {
      'data': '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getReceiptsList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsReceipts>(ClsReceipts.fromJson).toList();
  }

  static Future<List<ClsReceipts>> getFilteredReceiptsList(String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    print ("came");
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.http(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getFilteredReceiptsList',
        queryParameters);
    print (uri);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsReceipts>(ClsReceipts.fromJson).toList();
  }


}