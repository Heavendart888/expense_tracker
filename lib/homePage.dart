import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      backgroundColor: Colors.blue,
      appBar: AppBar(centerTitle: true,toolbarHeight: 70,
        actions: [Icon(Icons.search,color: Colors.white,)],
        leading: Padding(padding: EdgeInsets.all(3),child: CircleAvatar(child: Text("B",style: TextStyle(fontSize: 20),),radius: 50,),),
        backgroundColor: Colors.red,
        title: Text("Biswajit Info",),
        titleTextStyle: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,
        
        ),
        
        




        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [CircleAvatar(child: Text("BS",style: TextStyle(fontSize: 35,),),radius: 50,),
        Text("This is Flutter Developer.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        SizedBox(height: 26,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
            width: 160,
            height: 70,
            decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total Buy",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),)
            ],),
          
            margin: EdgeInsets.all(20),

          ),
          Container(
            width: 160,
            height: 70,
            
            child: Column(mainAxisAlignment:MainAxisAlignment.center, children: [
              

              Text("Total Sell",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
              


            ],),
          
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(7)),),
            
          )

            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(7))),
            
          
            margin: EdgeInsets.all(20),

          ),
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(7))),
          
            margin: EdgeInsets.all(20),

          ),



            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(7))),
          
            margin: EdgeInsets.all(20),

          ),
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(7))),
          
            margin: EdgeInsets.all(20),

          ),



            ],
          ),



      


        ],


      ),
      
      
      
      );
  }
}
