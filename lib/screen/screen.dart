import 'package:flutter/material.dart';
import 'package:note_application/helpers/hive_helpers.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState()=> _HomeScreenState();


}


class _HomeScreenState extends State<HomeScreen> {
    final _textCotroller = TextEditingController();
  
    List<String> titles =["Bussiness","Entertainment","Work","others"];
    List<Color> colors =[Colors.green,Colors.red,Colors.blue,Colors.yellow,Colors.purple,Colors.green,Colors.red,Colors.blue,Colors.yellow,Colors.purple];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 50, 82, 180),
      floatingActionButton: FloatingActionButton(

        onPressed: ()async{
         await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Note"),
                content: TextField(
                  controller: _textCotroller,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Add note here"),
                ),
                   actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      _textCotroller.text ="";
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      HiveHelpers.addNote(_textCotroller.text);
                      _textCotroller.text = "";
                    
                      Navigator.pop(context);
                      setState(() {});
                      
                    },
                  ),
                ]
              );
            },
          );
        },
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
         backgroundColor: const Color.fromARGB(255, 141, 173, 252),
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 50, 82, 180),
        leading: Icon(Icons.menu,color: Colors.white,),
        title: Text("NoteApp",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        
        actions: [
          Icon(Icons.search,color: Colors.white,),
          SizedBox(width: 10,),
           Icon(Icons.notification_add,color: Colors.white,),
          SizedBox(width: 10,),
        ],

      ),
      
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
           child:Column(
            children: [
              Row(
                children: [
                  Text("Hello,Youssef",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      HiveHelpers.removeAllNote();
                      setState(() {});
                    },
                    child:Icon(Icons.delete,color: Colors.white,), 
                  )
                  
                ],
              ),

              SizedBox(height: 20,),
              // Row(
              //   children: [
              //     Text("Categories",style: TextStyle(color: const Color.fromARGB(255, 109, 136, 225),fontSize: 20,fontWeight: FontWeight.bold),)
              //   ],
              // ),
              // SizedBox(height: 10,),
              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 125,
              //         child: ListView.separated(
                      
              //         itemCount: titles.length,
              //         scrollDirection: Axis.horizontal,
              //         shrinkWrap: true,
              //         physics: BouncingScrollPhysics(),
              //         separatorBuilder: (context, index) => SizedBox(width: 20,),
              //         itemBuilder: (context,index)=>Container(
                        
              //           height: 300,
              //           width: 200,
                    
              //           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              //           margin: EdgeInsets.only(bottom: 20),
              //           decoration: BoxDecoration(
              //             color: const Color.fromARGB(255, 17, 48, 101),
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("0 notes",style: TextStyle(color: const Color.fromARGB(255, 43, 68, 113),),),
              //               SizedBox(height: 5,),
              //               Text(titles[index],style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              //               SizedBox(height: 10,),
              //               Text("__________________________",style: TextStyle(color: Colors.blue),)
              //             ],
              //           ),

              //       )
              //       )
              //       ),
                    
              //       )
              //   ],


              // ),
           SizedBox(height: 20,),
           Row(
            children: [
              Text("Recent Notes",style: TextStyle(color: const Color.fromARGB(255, 109, 136, 225),fontSize: 20,fontWeight: FontWeight.bold),)
            ],
           ),
           SizedBox(height: 5,),
           Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: HiveHelpers.myNotes.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemBuilder: (context,index)=>InkWell(
                      onTap: () async{
                        await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Update a new Note'),
                      content: TextField(
                        controller: _textCotroller,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Enter the content of the Note.",
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('cancel'),
                          onPressed: () {
                            _textCotroller.text = "";
                           
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('Update'),
                          onPressed: () {
                            HiveHelpers.updateNote(_textCotroller.text, index);
                            _textCotroller.text = "";
                           
                            Navigator.pop(context);
                            setState(() {});
                           
                          },
                        ),
                         
                      ],
                    );
                  }
                           );

                      },
                     child:Container(

                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 17, 48, 101),
                        borderRadius: BorderRadius.circular(15),
                      ),
                     child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: colors[index],
                        ),
                        SizedBox(width: 15,),
                        Text(HiveHelpers.myNotes[index],style: TextStyle(color: Colors.white,fontSize: 20),),
                        Spacer(),
                        InkWell(
                          onTap: (){
                             HiveHelpers.removeNote(index);
                            setState(() {});
         },
                          child: Icon(Icons.delete,color: Colors.white,) ,
                        )
                       

                      ],
            
                     ),
            
                      ),  
                    ) ,
                    ),
                  ),
                ),
            ]
           ),

            
            ],
          ),

          )
        ),
        
    
     
       
      );
  }
}

