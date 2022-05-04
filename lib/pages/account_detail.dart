
import 'package:flutter/material.dart';
import '../components/setting/account_title_component.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';
class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({Key? key}) : super(key: key);
  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}
class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  Widget build(BuildContext context) {
    final resultUser = context.watch<DataProvider>().user;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userList.map((item) {
                      return AccountTitle(
                        user: resultUser,label:  item['title']!,
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final userList = [
  {
    'title': 'UserName',
  },
  {
    'title': 'Id',
  },
];
