import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'books_data.dart';

class DetailScreen extends StatefulWidget {
  final int albumIdx ;

  const DetailScreen({Key? key, required this.albumIdx}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  bool toggle = false;

  Widget build(BuildContext context) {
    final BooksData books_data = booksData[widget.albumIdx];
    return Scaffold(
        appBar: AppBar(
          title: Text(books_data.title),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon:
                toggle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    if (!await launch(books_data
                        .imageLinks)) throw 'Could not launch ${books_data
                        .imageLinks}';
                  }
              ),
            )
          ],
        ),
        body: ListView(children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.network(books_data.imageLinks),
                    ),
                    Text(
                      books_data.title,
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text("ID BUKU --> ${books_data.id}"),
                    Text("DESKRIPSI BUKU --> ${books_data.description}"),
                    Text("Authors --> ${books_data.authors}"),
                    Text("Publisher --> ${books_data.publisher}"),
                    Text("TANGGAL RILIS --> ${books_data.publishedDate}"),
                    Text("KATEGORI --> ${books_data.categories}"),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          "# |",
                          style: TextStyle(color: Colors.white),
                        ),
                        title: Text(
                          "PREVIEW GAMBAR BUKU",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(15),
                 child: SingleChildScrollView(
                     child: SizedBox(height: 400, child: _build_booksData())),
               )
            ],
          )
        ]));
  }
 Widget _build_booksData() {
   BooksData books_data = booksData[widget.albumIdx];
   return ListView.builder(
       itemBuilder: (context, index) {
         return InkWell(
           child: Card(
               child: Padding(
                 padding: const EdgeInsets.all(30),
                 child: Column(
                   children: [
                     Text(books_data.previewLink),
                     OutlinedButton(
                       onPressed: () {
                         Navigator.pop(context);
                         _launchURL(books_data.previewLink);
                       },
                       child: Text('Preview'),
                     )
                   ],
                 ),
               )
           ),
         );
       },
       itemCount: books_data.previewLink.length);
 }
  void _launchURL(_url) async {
    if(!await launch(_url)) throw 'Could not launch $_url';
  }
}
