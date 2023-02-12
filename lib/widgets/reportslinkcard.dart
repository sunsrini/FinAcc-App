import 'package:FinAcc/screens/testscroll.dart';
import 'package:flutter/material.dart';

class ReportsLinkCard extends StatelessWidget {
  const ReportsLinkCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: const Offset(0, 3),
                blurRadius: 10),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                    ),
                    child: Icon(
                      Icons.account_balance,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/daybook");
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                    ),
                    child: Icon(
                      Icons.balance,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/auctionhistory');
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () { Navigator.pushNamed(context, "/partylist"); },

                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                    ),
                    child: Icon(
                      Icons.list_alt,
                      size: 30,
                      color: Colors.orange,
                    ),
                    onPressed: () { Navigator.pushNamed(context, "/loansummarylist"); },
                  ),
                ],
              ),

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Day Book", style: TextStyle(fontSize: 14),),
                  Text("Auctions", style: TextStyle(fontSize: 14),),
                  Text("History", style: TextStyle(fontSize: 14),),
                  Text("Loans List", style: TextStyle(fontSize: 14),),
                ],
              ),
            ],
          ),
        )

    );
  }
}
