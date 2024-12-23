import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

TextEditingController textController = TextEditingController();
TextEditingController _mineClaimController =  TextEditingController();

 showInformativeDialog(String header,Color color,text,context){

  return showDialog(
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

Future<String?> claimMineDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Claim Mine',
          style: TextStyle(
            color: PrimaryColors().appDarkBlue,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: _mineClaimController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border: InputBorder.none,
              hintText: 'Enter Mine ID',
            ),
          ),
        ),
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
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
            onPressed: () {
              String? mineId = _mineClaimController.text.isNotEmpty ? _mineClaimController.text : null;
              Navigator.of(context).pop(mineId);
            },
            child: const Text(
              'Proceed',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
    },
  );
}

showInputDialog(context){

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
  // Navigator.pop(context);
  Navigator.of(context, rootNavigator: true).pop();
}