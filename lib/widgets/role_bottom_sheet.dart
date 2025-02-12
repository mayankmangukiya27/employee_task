import 'package:flutter/material.dart';

class RoleBottomSheet extends StatelessWidget {
   RoleBottomSheet({required this.roleList,required this.onTap});
   final List roleList;
   final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:roleList.length ,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
        return InkWell(
          onTap: ()=> onTap(roleList[index]),
          child: Column(
            children: [
              SizedBox(height:index==0? 10:0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Center(child: Text(roleList[index]))),
              SizedBox(height: 10,),
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFFF2F2F2),
              )
            ],
          ),
        );

    });
  }
}
