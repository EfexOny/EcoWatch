
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final List<String> entry =const <String>['Hartie','B'];
    
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Text("History",style: GoogleFonts.montserrat(
              fontSize: 36,
              color: Colors.black,
              letterSpacing: 20,
                ),),
          ),
          Expanded(child: 
          ListView.builder(
            itemCount: entry.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height*0.10,
                width: double.infinity,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [Colors.blueAccent,Colors.cyanAccent],begin:Alignment.topLeft ,end: Alignment.bottomLeft)
                ) ,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.report_problem_rounded),
                          Text(entry[index])
                        ],
                       ),
                       Text("24.03.2040 , 8:20 PM",textAlign: TextAlign.start,),
                     ],
                   ),
                  
                    ),
                ),
              ),
            );
          },))
        ],
      ),
    );
  }
}