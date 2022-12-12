import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_app_sqlite/cubit/anasayfa_cubit.dart';
import 'package:kisiler_app_sqlite/model/kisiler.dart';
import 'package:kisiler_app_sqlite/views/kisi_detay_sayfa.dart';
import 'package:kisiler_app_sqlite/views/kisi_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyormu = false;
  @override
  void initState() {

    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyormu ?
            TextField(decoration: const InputDecoration(hintText: "ara"),
            onChanged: (aramaSonucu){
              context.read<AnasayfaCubit>().ara(aramaSonucu);
            },
            )
        :const Text("Kişiler"),
        actions: [
          aramaYapiliyormu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyormu = false;
              context.read<AnasayfaCubit>().kisileriYukle();
            });
          }, icon: const Icon(Icons.cancel)):
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyormu = true;
            });

          }, icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(

        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
                itemBuilder: (context,index){
                 var kisi = kisilerListesi[index];
                 return GestureDetector(
                   onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> KisiDetaySayfa(kisi: kisi)))
                        .then((value) {     context.read<AnasayfaCubit>().kisileriYukle();});

                   },
                   child: Card(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                            Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                       const   Spacer(),
                         IconButton(onPressed: (){
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("${kisi.kisi_ad} silinsin mi?"),
                             action:

                             SnackBarAction(
                                 label: "Evet", onPressed: (){
                                   context.read<AnasayfaCubit>().sil(kisi.kisi_id);
                                 }),

                             )
                           );
                         }, icon:Icon(Icons.delete ,color: Colors.black54,))
                         ],
                       ),
                     ),
                   ),
                 );
                }
            );
          }else{
            
          }
        return Container(

        );
          },

      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const KisiKayitSayfa()))
                .then((value) {    context.read<AnasayfaCubit>().kisileriYukle();});

          },
          child: const Icon(Icons.add),
      ),
    );
  }
}
