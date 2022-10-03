import 'package:Quiz_Praktikum_Mobile/source_code/detail_screen.dart';
import 'books_data.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Buku"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final BooksData books_data = booksData[index];
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return DetailScreen(albumIdx: index);
                          })
                      );
                    },
                    child:
                    Card(
                      child: Image.network(books_data.imageLinks,
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(books_data.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 40,
                    ),),
                  SizedBox(height: 15,),
                  Text(books_data.authors[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 40,
                    ),),
                  SizedBox(height: 15,),
                  Text(books_data.publishedDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 40,
                    ),),
                  SizedBox(height: 15,),
                  Text(books_data.categories[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 40,
                    ),),
                ],
              );
            },
            itemCount: booksData.length,
          ),
        )
    );
  }
}