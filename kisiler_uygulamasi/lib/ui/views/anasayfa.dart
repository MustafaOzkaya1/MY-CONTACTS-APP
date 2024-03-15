import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyormu = false;


  Future<void> ara(String aramaKelimesi) async {
    print("Kişi ara : $aramaKelimesi");
  }
  Future <void> sil(int kisi_id,) async{
    print("Kişi Sil: $kisi_id ");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Mehmet", kisi_tel: "2121");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "Ali", kisi_tel: "3333");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyormu
            ? TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            ara(aramaSonucu);
          },
        )
            : const Text("Kişiler"),
        actions: [
          aramaYapiliyormu
              ? IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyormu = false;
                });
              },
              icon: const Icon(Icons.clear))
              : IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyormu = true;
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Kisiler>>(
        future: kisileriYukle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             var kisilerListesi = snapshot.data;
             return ListView.builder(itemCount: kisilerListesi!.length,//3
               itemBuilder: (context,indeks){//0,1,2
               var kisi =  kisilerListesi[indeks];
               return GestureDetector(
                 onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi))
                   ).then((value) {
                   });
                 },
                 child: Card(
                   child: SizedBox(height: 100,
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(kisi.kisi_ad,style: const TextStyle(fontSize: 20),),
                               Text(kisi.kisi_tel),
                             ],
                           ),
                         ),
                         const Spacer(),
                         IconButton(
                             onPressed: () {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${kisi.kisi_ad} silinsin mi ?"),
                                 action: SnackBarAction(
                                   label: "Evet",
                                   onPressed: (){
                                     sil(kisi.kisi_id);

                                   },
                                 ),
                               )
                               );
                               
                             },
                             icon: const Icon(Icons.clear,color: Colors.black54,))
                 
                 
                       ],
                 
                     ),
                   ),
                 
                 ),
               );
               },

             );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Hata: ${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KayitSayfa())
          ).then((value) {
            print("Anasayfa dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  }



