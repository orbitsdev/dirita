




import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/account_card_widget.dart';


enum AccountType{
  visitor,
  admin,
  superadmin
} 


class AccountSelectionScreen extends StatelessWidget {
const AccountSelectionScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Account Type'),
        backgroundColor: AppTheme.BACKGROUND,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppTheme.BACKGROUND,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        physics: const BouncingScrollPhysics(),
        children: [   
       
            AccountCardWidget(
              color: Colors.white,
              name: 'Tourist',
              image: 'drone-pilot-lottie.json',
            ),
            AccountCardWidget(
              color: Colors.white,
              name: 'Tourist Spot Manager',
              image: 'administracao.json',
            ),
            AccountCardWidget(
              color: Colors.white,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
          
        
        ],
      ),
    );
  }
}