import 'package:flutter/material.dart';
import 'package:assurance/constants/constants.dart';
import 'dart:io';


class WidgetFileListView {

  static int counteron, counterlong;
  static ListView listView;
  static List list;
  Widget longPressedFileWidget;
  int longPressedFileInt;
  static Function onPressFunction, longPressFunction, deleteFileFunction;


  WidgetFileListView(Function opf, Function lpf){
    counter_init();
    //setFunctions(opf, lpf);
  }

  void counter_init() {
    counteron = 0;
    counterlong = 0;
  }

  void setFunctions(Function opf, Function lpf) {
    onPressFunction = opf;
    longPressFunction = lpf;
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////

  static Widget widget_file_listview(BuildContext context, List l, Function onPress,
        Function onLongPress) {
    list = l;
    onPressFunction = onPress;
    longPressFunction = onLongPress;
    listView = ListView(
      scrollDirection: Axis.horizontal,
      children: listView_builder(list),
    );
    return listView;
  }



  static List<Widget> listView_builder(List list) {
    List<Widget> listWidget;
    for(int i=0; i<list.length; i++){
      listWidget.add(SizedBox(width: 12));
      listWidget.add(build_card(list[i], i));
    }
    return listWidget;
  }



  static Widget build_card(Widget w, int i) {
    File file = w as File;
    return Card(
      elevation: 8.0,
      child: ListTile(
        onTap: () {
          counteron++;
          if(counteron>0){
            onPressFunction(i);
          }
        },
        onLongPress: () {
          counterlong++;
          if(counterlong>0){
            longPressFunction(i);
            selectFile(i);
          }
        },
        leading: Card(
          color: Colors.white60,
          elevation: 1.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Icon(Icons.insert_invitation_rounded, color: Colors.blue),
            child: Image.asset(
                    Constants.icExcelIcon,
                  ),
          ),
        ),
        title: Text(file.path.split('/').last),   // File name
        //subtitle: Text(invitacion['fecha_inicial'] + ' - ' + invitacion['fecha_final']),
        
      ),
    );
  }









  List selectedFileOnPress(){   // Returns index and file of selected file

  }



  static void selectFile(int i){
    // marcar como seleccionado
    // setState en page
  }



  void deleteFiles(List filesToDelete){    // Delete from the listView
    for(int i=0; i<filesToDelete.length; i++){
      list.removeAt(filesToDelete[i] as int);
    }
    listView = ListView(
      scrollDirection: Axis.horizontal,
      children: listView_builder(list),
    );
    // setState en la page
  }

}
