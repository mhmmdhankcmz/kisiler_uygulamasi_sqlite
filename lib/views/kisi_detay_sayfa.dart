import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_app_sqlite/cubit/kisi_detay_cubit.dart';
import 'package:kisiler_app_sqlite/model/kisiler.dart';

class KisiDetaySayfa extends StatefulWidget {
 Kisiler kisi;


 KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}
class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAd.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAd, decoration: const InputDecoration( hintText: "Kişi adı"),),
              TextField(controller: tfKisiTel, decoration: const InputDecoration( hintText: "Kişi Tel"),),
              ElevatedButton(onPressed: (){
                context.read<KisiDetayCubit>().guncelle(widget.kisi.kisi_id, tfKisiAd.text, tfKisiTel.text);
              }, child: Text("Güncelle")),
            ],
          ),
        ),
      ),
    );
  }
}
