import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expense App',
        home: HomePage(),
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.blue[900],
            errorColor: Colors.red[900],
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Travel',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Shoe',
    //   amount: 50.29,
    //   date: DateTime.now(),
    // )
  ];
  bool _showChart=false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewTx(String txtitle, double txamount, chosenDate) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addnewTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }
  Widget ifLandScapeWidget(){
    return Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[Text('Show Chart'),
                  Switch(value:_showChart,onChanged:(val){
                    setState((){
                      _showChart=val;
                    });
                  })],);

  }
  @override 
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isLandscape= mediaQuery.orientation==Orientation.landscape;
    final appBar =
        AppBar(title: Text('Personal Expense App'), actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    ]);
    final txList=Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height-mediaQuery.padding.top) *
                      0.7,
                  child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if(isLandscape) ifLandScapeWidget(),
                  if(!isLandscape)
                  Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height-mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
                  if(!isLandscape) txList,
                  if(isLandscape)_showChart?
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height-mediaQuery.padding.top) *
                      0.7,
                  child: Chart(_recentTransactions))
                  :txList,
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
