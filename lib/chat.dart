import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rag_api.dart';





class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen>  {
  final TextEditingController _uservalue = TextEditingController();
  List<String> _messages = [];



  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    _uservalue.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top]);
    super.dispose();
  }


  

  @override
  Widget build(BuildContext context) {   



    
    //! =================================================================== Appbar ==================================================
    IconButton h = IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back,size: 30,color: Color(0xffa3502b)));
    AppBar appbar =  AppBar(actions: [Image.asset("assets/images/logo.png",width: 80,height: 80,)],leading: h,elevation: 0,backgroundColor: const Color(0xffe7c8ad),title: Text("Ryle Chatbot",style: TextStyle(fontSize: 30,color: Color(0xffa3502b))),centerTitle: true,shape: Border(bottom: BorderSide(color: Color(0xffa3502b),  width:3.0)));

    //! =================================================================== Bottuns ==================================================
    IconButton add_button =  IconButton(onPressed: () => clear_messages(),icon: const Icon(Icons.delete, size: 40),color: const Color(0xFF77573E),);

    IconButton send_button =  IconButton(onPressed: () => Add_messages(),icon: const Icon(Icons.send_rounded, size: 22),color: Colors.white,);
    Container hala = Container(child: send_button,decoration: BoxDecoration(color: Color(0xFF77573E),borderRadius: BorderRadius.circular(180)),);

    //! =================================================================== Textfeild and Button ==================================================

    TextField feild = TextField(controller: _uservalue,textAlign: TextAlign.center,textDirection: TextDirection.rtl,
    decoration: const InputDecoration(fillColor: Color(0xfff8ede2),filled: true,hintText: 'Type Your Question...',
    enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) ),
    border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) )),
    );

    Row feild_controls = Row(children: [add_button,Expanded(child: feild),hala],spacing: 8);


    //! ============================================================= Messages Control ================================
    ListView messages = ListView.builder(itemCount: _messages.length,itemBuilder: (context , index) => Messages_query(context, index));

    //! ============================================================= Middle Text ================================
    Text text =  Text("Let’s start our conversation!",style: TextStyle(fontSize: 25,color: Colors.black87,fontFamily: 'AGaramondPro',fontWeight: FontWeight.bold,));

    //! ============================================================= Application Arc ================================

    Column controls = Column(children: _messages.isEmpty?[Expanded(child: Center(child: text)),feild_controls]:[Flexible(child: messages),feild_controls]  ,mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start,);
    BoxDecoration decoration = BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/final2.png'),fit: BoxFit.cover,),color: Colors.amber);
    Container main_app = Container(decoration: decoration,child:controls ,padding: EdgeInsets.only(left:5, bottom:20, right:5));

    return Scaffold(body: main_app,appBar: appbar);

  }



  void Add_messages() async{
    if (_uservalue.text.trim().isNotEmpty){
      _messages.add(_uservalue.text);
      setState(() {});

      if (await RagApi.hasInternet() == true){
      final result = await RagApi.rag_response(question: _uservalue.text.trim());
      _messages.add(result);
      setState(() {});
      }

      else{
        _messages.add('oops! No response generated, Check your internet connection');
        setState(() {});
      }

      }
    _uservalue.clear();
  }

  void clear_messages(){
    _messages.clear();
    setState(() {});
  }




  Row Messages_query (context, int index) {
    final msg = _messages[index];

    final double width = MediaQuery.of(context).size.width; 



    if ( msg == "oops! No response generated, Check your internet connection"){
      Text Mess = Text(msg,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800));
      Container bubble = Container(child:Mess,padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(bottom: 6,top: 10),width: width - 75,
      decoration: BoxDecoration(color: Colors.redAccent,borderRadius: const BorderRadius.all(Radius.circular(15))));
      return Row(mainAxisAlignment: MainAxisAlignment.start,children: [const Icon(Icons.error,color: Colors.redAccent,size: 40) ,bubble]);
    }


    else if ( _messages.isNotEmpty && index.isEven){
      Text Mess = Text(msg,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800));
      Container bubble = Container(child:Mess,padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(bottom: 6,top: 10),
      decoration: BoxDecoration(color: Colors.white,borderRadius: const BorderRadius.all(Radius.circular(15))));
      return Row(mainAxisAlignment: MainAxisAlignment.end,children: [bubble,const Icon(Icons.person_pin_outlined,color: Color(0xff77573d),size: 40)]);
    }

    else {
      Text Mess = Text(msg,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),textAlign: TextAlign.center,);
      
      Container bubble = Container(child:Mess,padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(bottom: 6,top: 10),width: width - 80,
      decoration: BoxDecoration(color: Colors.white,borderRadius: const BorderRadius.all(Radius.circular(15))));
      Container chatbot_icon = Container(child: Center(child: Image.asset("assets/images/logo.png",width: 40,height: 40,fit: BoxFit.fitHeight)),decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(20)),alignment: Alignment.center);
      return  Row(children: [chatbot_icon,bubble],mainAxisAlignment: MainAxisAlignment.start,spacing: 5);
    }

  }



    
}





