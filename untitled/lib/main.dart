import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[900],
  ),
));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  String selected = '1';
  double totalInterest = 0.0;
  double monthlyInterest = 0.0;
  double monthlyInstallment = 0.0;

  void loancalculation() {
    final amount = int.parse(controller.text) - int.parse(controller1.text);
    final tinterest =
        amount * (double.parse(controller2.text) / 100 * int.parse(selected));
    final minstall = (amount + tinterest) / (int.parse(selected) * 12);
    final minterest = tinterest / (int.parse(selected) * 12);

    setState(() {
      totalInterest = tinterest;
      monthlyInterest = minterest;
      monthlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.notes,
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.blueGrey[900],
        elevation: 5,
        title: Text(
          'Kredi Hesaplayıcı',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info_outline,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey[900]!, Colors.blueGrey[700]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Araç Kredisi Hesaplayıcı',
                      style: GoogleFonts.robotoMono(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputForm(
                    title: 'Araç Fiyatı',
                    hintText: 'Örneğin 90000',
                    controller: controller),
                inputForm(
                    title: 'Peşinat',
                    hintText: 'Örneğin 9000',
                    controller: controller1),
                inputForm(
                    title: 'Faiz Oranı (%)',
                    hintText: 'Örneğin 3.5',
                    controller: controller2),
                Text(
                  'Kredi Süresi (Yıl)',
                  style: GoogleFonts.robotoMono(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    loanPeriod('1'),
                    loanPeriod('2'),
                    loanPeriod('3'),
                    loanPeriod('4'),
                    loanPeriod('5'),
                    loanPeriod('6'),
                    loanPeriod('7'),
                    loanPeriod('8'),
                    loanPeriod('9'),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    loancalculation();
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: false,
                        backgroundColor: Colors.blueGrey[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Sonuçlar',
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                results(
                                    title: 'Toplam Faiz',
                                    amount: totalInterest),
                                results(
                                    title: 'Aylık Faiz',
                                    amount: monthlyInterest),
                                results(
                                    title: 'Aylık Taksit',
                                    amount: monthlyInstallment),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[700],
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Yeniden Hesapla',
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[700],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Hesapla',
                        style: GoogleFonts.robotoMono(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget results({required String title, required double amount}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          '₺' + amount.toStringAsFixed(2),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget loanPeriod(String title) {
    return GestureDetector(
      onTap: () {
        debugPrint(title);
        setState(() {
          selected = title;
        });
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: title == selected
              ? Border.all(color: Colors.amber, width: 2)
              : null,
          color: Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Widget inputForm(
      {required String title,
        required TextEditingController controller,
        required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white, fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
