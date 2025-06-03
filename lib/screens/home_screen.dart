import 'package:backg_remove/constants/myimage.dart';
import 'package:backg_remove/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState()=> HomeScreenState();
}
class HomeScreenState extends State<HomeScreen>{
  Uint8List? resultImage;
  @override
  Widget build(BuildContext context){
    HomeController controller = HomeController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Remove'),centerTitle: true,backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
            child: Column(
                    children: [
                      resultImage == null ?
                      Image.asset(MyImage.testimage):
                      Image.memory(resultImage!)
                      ,
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                      child: ElevatedButton(onPressed: ()async{
                        Uint8List? imageBytes= await controller.pickImage();
        
                        if(imageBytes ==null){
                          return;
                        }
                        resultImage =await controller.removeBackGround(imageBytes);
                        setState(() {
        
                        });
                      },
                          child: Text('Pick Image')))
                    ],
            ),
          ),
      ),
    );
  }
}