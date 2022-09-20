import 'package:capgain/CapGainWidgets/CapGainWidgets.dart';
import 'package:capgain/CapGainWidgets/CustomDropDown.dart';
import 'package:capgain/first_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CapitalGainsTaxPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CapitalGainsTaxPage extends StatefulWidget {
  const CapitalGainsTaxPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CapitalGainsTaxPage> createState() => CapitalGainsTaxPageState();
}

class CapitalGainsTaxPageState extends State<CapitalGainsTaxPage> {

  final asyncMemoizer = AsyncMemoizer();

  Map<String, String?> params = {
    "양도예정일":null,
    "주소":null,
    "양도시 종류":null,
    "취득 원인":null,
    "취득시 종류":null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1000,
            ),
            child: FutureBuilder(
                future: getCSVonce(),
                builder: (context,snapshot){
                  return ListView.builder(
                      itemCount: baseInfo.length,
                      itemBuilder: (context, index){
                        if(baseInfo[index]['type'] == 'date'){
                          return Container(child: Text('type == date'),);
                        }
                        else if (baseInfo[index]['type'] == 'address'){
                          return Text('type == address');
                        }
                        else if(baseInfo[index]['type'] == 'dropdown'){
                          return typeDropDown(index,true);
                        }
                        else {
                          return const Text('baseinfo type error : 해당하는 타입이 없습니다.');
                        }

                      }
                  );
                }
            ),
          ),
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget typeDate(int index, bool activated){
    DateTime transferDate;

    return Column(
      children: [
        smallTitle(baseInfo[index]['smallTitle']),
        Row(
          children: [
            Text(''),
            TextButton(
                onPressed: (){

                },
                child: Text('날짜 선택')
            ),
          ],
        )
      ],
    );
  }

  Widget typeDropDown(int index, bool activated){
    //CustomDropDown _dropDown = CustomDropDown(items: baseInfo[index]['contents'], activated: activated, widgetName: baseInfo[index]['smallTitle']);

    List<String>? contents = baseInfo[index]['contents'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        smallTitle(baseInfo[index]['smallTitle']),
        DropdownButton(
          value: params[baseInfo[index]['smallTitle']],
            items: ((){
              if(contents != null){
                return contents.map(
                        (value){
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value)
                      );
                    }
                ).toList();
              }
              else {return null;}
            })(),
            onChanged: (value){
              setState(() {
                params[baseInfo[index]['smallTitle']] = value as String;
              });
            }
        )
      ],
    );
  }


  Future getCSVonce() => asyncMemoizer.runOnce(()async{
    String _rawData2 = await rootBundle.loadString('assets/capgain/AcquisitionDate.CSV');

    List<List<dynamic>> listData2 = []; //=  CsvToListConverter().convert(_rawData2);

    List<String> _l2 = _rawData2.split('\n');
    for(int i = 0 ; i < _l2.length - 1 ;i++){
      listData2.add(_l2[i].split(','));
      if(listData2[i][7] != null && listData2[i][7].length > 0){
        listData2[i][7] = listData2[i][7].toString().substring(0,listData2[i][7].length - 1);
      }
    }

    return listData2;
  });
}
