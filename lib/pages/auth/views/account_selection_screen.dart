




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
       
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
     
      body:
      ListView(
        padding: EdgeInsets.symmetric(horizontal: 8,),
        physics: const BouncingScrollPhysics(),
        children: [   

            
            AccountCardWidget(
               color: AppTheme.CARD8,
              name: 'Tourist',
              image: 'drone-pilot-lottie.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD3,
              name: 'Tourist Spot Manager',
              image: 'administracao.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD3,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD4,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD5,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD6,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD7,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD8,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD9,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD10,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD11,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD12,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD13,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD14,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD15,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD16,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
            AccountCardWidget(
              color: AppTheme.CARD17,
              name: 'Dirikita Admin',
              image: 'admin.json',
            ),
          
        
        ],
      ),
    );
  }
}