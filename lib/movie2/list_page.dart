import 'package:flutter/material.dart';
import 'data.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        elevation: 11,
      ),
      body: ListView.builder(
        itemCount: Data.movieList['results'].length,
        itemBuilder: (context, i) {
          var data = Data.movieList['results'];
          return _cardItem(data[i]);
        },
      ),
    );
  }

  Widget _cardItem(Map<dynamic, dynamic> data) {
    String? imageUrl = data['poster_path'] != null ? "https://image.tmdb.org/t/p/w500${data['poster_path']}" : null;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: imageUrl != null 
          ? Image.network(
              imageUrl, 
              width: 50, 
              height: 50, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image, color: Colors.orange[800]),
            )
          : Icon(Icons.image, color: Colors.orange[800]),
        title: Text(data['title'] ?? 'No Title', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Release: ${data['release_date'] ?? '-'}"),
        trailing: Text(data['vote_average']?.toString() ?? '-'),
        isThreeLine: false,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(movieData: data),
            ),
          );
        },
      ),
    );
  }
}
