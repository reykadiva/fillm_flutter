import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> movieData;

  const DetailPage({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    String? imageUrl = movieData['poster_path'] != null ? "https://image.tmdb.org/t/p/w500${movieData['poster_path']}" : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(movieData['title'] ?? 'Detail Movie'),
        backgroundColor: Colors.orange[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  Container(height: 400, color: Colors.grey, child: Icon(Icons.image, size: 100)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieData['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Tanggal Rilis: ${movieData['release_date'] ?? '-'} | Rating: ${movieData['vote_average'] ?? '-'}"),
                  SizedBox(height: 10),
                  Text("Popularitas: ${movieData['popularity'] ?? '-'}"),
                  SizedBox(height: 20),
                  Text(
                    "Overview:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(movieData['overview'] ?? 'Tidak ada deskripsi.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}