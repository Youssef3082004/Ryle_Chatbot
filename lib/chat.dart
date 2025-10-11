import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ChatScreen2 extends StatefulWidget {
  const ChatScreen2({super.key});

  @override
  State<ChatScreen2> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen2>  {
  final TextEditingController _uservalue = TextEditingController();
  List<String> _messages = [];

  String name = "Ryla Tour Guide";


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    _uservalue.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }


  

  @override
  Widget build(BuildContext context) {    

    
    //! =================================================================== Appbar ==================================================
    IconButton h = IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back,size: 30,color: Color(0xffa3502b)));
    AppBar appbar =  AppBar(actions: [Image.asset("assets/images/icon.png",width: 80,height: 80,)],leading: h,elevation: 0,backgroundColor: Colors.transparent,title: Text("Your tour guide",style: TextStyle(fontSize: 40,color: Color(0xffa3502b))),centerTitle: false,shape: Border(bottom: BorderSide(color: Color(0xffa3502b),  width:3.0)));


    //! =================================================================== Bottuns ==================================================
    // IconButton add_button =  IconButton(onPressed: () {},icon: const Icon(Icons.add_box_outlined, size: 40),color: const Color(0xFF77573E),);

    IconButton send_button =  IconButton(onPressed: () => Add_messages(),icon: const Icon(Icons.send_rounded, size: 22),color: Colors.white,);
    Container hala = Container(child: send_button,decoration: BoxDecoration(color: Color(0xFF77573E),borderRadius: BorderRadius.circular(180)),);


    //! =================================================================== Bottuns ==================================================

    TextField feild = TextField(controller: _uservalue,
    decoration: const InputDecoration(fillColor: Color(0xfff8ede2),filled: true,hintText: 'Type your message...',
    enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) ),
    border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) )),
    );


    




    Expanded messages = Expanded(
  child: ListView.builder(
    reverse: true, // newest message at bottom
    // padding: const EdgeInsets.all(10),
    itemCount: _messages.length,
    itemBuilder: (context, index) {
      final msg = _messages[_messages.length - 1 - index];
      Text Mess = Text(msg,style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w800),);
      Container c = Container(padding: EdgeInsets.all(10),margin: EdgeInsets.only(left: 2),child: Mess,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(15))));
      Icon person_icon = Icon(Icons.person_pin_outlined,color: const Color(0xff77573d),size: 40,); 
      return Row(children: [c,person_icon],mainAxisAlignment: MainAxisAlignment.end,spacing: 5,);
      
    },
  ),
);

    
    //! ============================================================= Textfeild in application ================================

    Row feild_controls = Row(children: [Expanded(child: feild),hala],spacing: 8);

    Expanded text = Expanded(child: Center(child: Text(name,style: TextStyle(fontSize: 25,color: Colors.black,fontFamily: 'AGaramondPro',fontWeight: FontWeight.bold,),),),);


    // Column Messages = Column(children: [text],crossAxisAlignment: CrossAxisAlignment.start);
    Column controls = Column(children: [messages,text,feild_controls],mainAxisAlignment: MainAxisAlignment.center);
    BoxDecoration decoration = BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/final2.png'),fit: BoxFit.cover,),);
    Container main_app = Container(decoration: decoration,child:controls ,padding: EdgeInsets.only(left:5, bottom:20, right:5),);

    return Scaffold(body: main_app,appBar: appbar,extendBodyBehindAppBar: true);

  }



  void Add_messages(){
    if (_uservalue.text.trim().isNotEmpty){
      _messages.add(_uservalue.text);
      setState(() {name = '';});
      }
    _uservalue.clear();
  }



}