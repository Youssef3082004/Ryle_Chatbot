import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;





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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }


  

  @override
  Widget build(BuildContext context) {    

    
    //! =================================================================== Appbar ==================================================
    IconButton h = IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back,size: 30,color: Color(0xffa3502b)));
    AppBar appbar =  AppBar(actions: [Image.asset("assets/images/icon.png",width: 80,height: 80,)],leading: h,elevation: 0,backgroundColor: const Color(0xffe7c8ad),title: Text("Your tour guide",style: TextStyle(fontSize: 40,color: Color(0xffa3502b))),centerTitle: false,shape: Border(bottom: BorderSide(color: Color(0xffa3502b),  width:3.0)));

    //! =================================================================== Bottuns ==================================================
    IconButton add_button =  IconButton(onPressed: () => clear_messages(),icon: const Icon(Icons.delete, size: 40),color: const Color(0xFF77573E),);

    IconButton send_button =  IconButton(onPressed: () => Add_messages(),icon: const Icon(Icons.send_rounded, size: 22),color: Colors.white,);
    Container hala = Container(child: send_button,decoration: BoxDecoration(color: Color(0xFF77573E),borderRadius: BorderRadius.circular(180)),);

    //! =================================================================== Textfeild and Button ==================================================

    TextField feild = TextField(controller: _uservalue,
    decoration: const InputDecoration(fillColor: Color(0xfff8ede2),filled: true,hintText: 'Type your message...',
    enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) ),
    border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) )),
    );

    Row feild_controls = Row(children: [add_button,Expanded(child: feild),hala],spacing: 8);


    //! ============================================================= Messages Control ================================
    ListView messages = ListView.builder(itemCount: _messages.length,itemBuilder: (context , index) => Messages_query(context, index));

    //! ============================================================= Middle Text ================================
    Text text =  Text("Ryla Tour Guide",style: TextStyle(fontSize: 25,color: Colors.black,fontFamily: 'AGaramondPro',fontWeight: FontWeight.bold,));

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

      if (await hasInternet() == true){
      final parts = [Part.text(_uservalue.text.trim())];
      final response = await Gemini.instance.prompt(parts: parts);
      _messages.add(response?.output?? 'No response generated');
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


  Future<bool> hasInternet() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }



  Row Messages_query (context, int index) {
    final msg = _messages[index];

    if ( _messages.isNotEmpty && index.isEven){
      Text Mess = Text(msg,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800));
      Container bubble = Container(child:Mess,padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(bottom: 6,top: 10),
      decoration: BoxDecoration(color: Colors.white,borderRadius: const BorderRadius.all(Radius.circular(15))));
      return Row(mainAxisAlignment: MainAxisAlignment.end,children: [bubble,const Icon(Icons.person_pin_outlined,color: Color(0xff77573d),size: 40)]);
    }

    else {
      
      Container bubble = Container(child:Markdown(data: msg,shrinkWrap: true,),padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(bottom: 6,top: 10),width: 300,
      decoration: BoxDecoration(color: Colors.white,borderRadius: const BorderRadius.all(Radius.circular(15))));
      Container chatbot_icon = Container(child: Image.asset("assets/images/icon.png",width: 40,height: 40),decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(20)),alignment: Alignment.center);
      return  Row(children: [chatbot_icon,bubble],mainAxisAlignment: MainAxisAlignment.start,spacing: 5);
    }

  }



    
}





