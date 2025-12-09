import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Backend/rag_api.dart';





class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen>  {
  final TextEditingController _uservalue = TextEditingController();
  List<String> _messages = [];
  bool loading = false;



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
    final Color _primaryColor = const Color(0xFF6D4C41); 
    final Color _backgroundColor = const Color(0xFFFBF0E9);    

    //! =================================================================== Appbar ==================================================
    // IconButton BackButton = IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back,size: 30));
    IconButton Arscreen = IconButton(onPressed: () => Navigator.pushNamed(context,"/arscreen"),icon: Icon(Icons.view_in_ar,size: 30));
    AppBar appbar =  AppBar(backgroundColor: _primaryColor,foregroundColor: Colors.white, actions: [Image.asset("assets/images/logo.png")],leading: Arscreen,elevation: 0,title: Text("Ryle Chatbot",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true);

    //! =================================================================== Bottuns ==================================================
    IconButton add_button =  IconButton(onPressed: () => clear_messages(),icon: const Icon(Icons.delete, size: 40),color: _primaryColor,);

    IconButton send_button =  IconButton(onPressed: () => Add_messages(),icon: const Icon(Icons.send_rounded, size: 22),color: Colors.white,);
    Container hala = Container(child: send_button,decoration: BoxDecoration(color: _primaryColor,borderRadius: BorderRadius.circular(180)),);

    //! =================================================================== Textfeild and Button ==================================================

    TextField feild = TextField(controller: _uservalue,textAlign: TextAlign.center,textDirection: TextDirection.rtl,cursorColor: Color(0xFF77573E),
    decoration: const InputDecoration(fillColor: Color(0xfff8ede2),filled: true,hintText: 'Type Your Question...',
    enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) ),
    focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) ),
    border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12.0)),borderSide: BorderSide(color: Color(0xFF77573E),width: 2.0) )),
    );

    Row feild_controls = Row(children: [add_button,Expanded(child: feild),hala],spacing: 8);


    //! ============================================================= Messages Control ================================
    ListView messages = ListView.builder(itemCount: _messages.length,itemBuilder: (context , index) => Messages_query(context, index));

    //! ============================================================= Middle Text ================================
    Text text =  Text("Let’s start our conversation!",style: TextStyle(fontSize: 25,color: Colors.black87,fontFamily: 'AGaramondPro',fontWeight: FontWeight.bold,));


    Widget loadingIndicator = loading 
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(spacing: 5, 
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40, height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset("assets/images/logo.png", width: 40, height: 40, fit: BoxFit.fitHeight),
                ),
                const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6D4C41)),
                ),
              ],
            ),
          )
        : const SizedBox.shrink(); 


    //! ============================================================= Application Arc ================================

    Column controls = Column(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start,children: [_messages.isEmpty ? Expanded(child: Center(child: text)) : Flexible(child: messages),loadingIndicator,feild_controls ],);
    Container main_app = Container(child:controls ,padding: EdgeInsets.only(left:5, bottom:20, right:5),color: _backgroundColor,);
    return Scaffold(body: main_app,appBar: appbar,);

  }



 void Add_messages() async {
    
    if (_uservalue.text.trim().isEmpty) return;

    final userText = _uservalue.text.trim();

    setState(() {
      _messages.add(userText);
      loading = true; 
      _uservalue.clear(); 
    });

    String result;

    
    if (await RagApi.hasInternet() == true) {
      result = await RagApi.rag_response(question: userText);
    } else {
      result = 'oops! No response generated, Check your internet connection';
    }

    
    if (!mounted) return; 
    setState(() {
      _messages.add(result);
      loading = false; 
    });
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