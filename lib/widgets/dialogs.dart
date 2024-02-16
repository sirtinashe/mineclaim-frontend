import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

 showInformativeDialog(String header,Color color,text,context){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title:  Text(header,style: TextStyle(color: color),),
      content: Text(
          text),
      actions: <Widget>[
        ElevatedButton(

          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(PrimaryColors().appDarkBlue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // onPressed: _goToLogin,
          onPressed: () {
            Navigator.of(context).pop();

          },
          child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white,fontSize: 16 ,fontWeight: FontWeight.w700)
          ),
        ),
      ],
    ),
  );
}
 showActionDialog(String header,Color color,text,context){
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title:  Text(header,style: TextStyle(color: color),),
      content: Text(
          text),
      actions: <Widget>[
        ElevatedButton(

          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // onPressed: _goToLogin,
          onPressed: () {
            Navigator.of(context).pop(false);

          },
          child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white,fontSize: 16 ,fontWeight: FontWeight.w700)
          ),
        ),
        ElevatedButton(

          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(PrimaryColors().appDarkBlue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // onPressed: _goToLogin,
          onPressed: () {
            Navigator.of(context).pop(true);

          },
          child: const Text(
              'Proceed',
              style: TextStyle(color: Colors.white,fontSize: 16 ,fontWeight: FontWeight.w700)
          ),
        ),

      ],
    ),
  );
}
 showProcessingDialog(context) async{
  return showDialog(

      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){

        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(10.0))
            // ),
            contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: const SizedBox(
                width: 250.0,
                height: 100.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      // Text("Please Wait",

                    ]
                )
            )


        );
      }
  );
}

dismissDialog(context) async{
  Navigator.pop(context);
}