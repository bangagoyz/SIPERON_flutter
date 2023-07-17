import 'package:flutter/material.dart';
import '../../Utils/constants.dart';
import '../../api/apiConfig.dart';

class SearchBook extends SearchDelegate {
  List dataBuku;
  List filteredData;

  SearchBook({required this.dataBuku}) : filteredData = dataBuku;

  @override
  String get searchFieldLabel => 'Cari buku';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display the search results
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        return cardBuku(filteredData[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display the search suggestions
    filteredData = query.isEmpty
        ? dataBuku
        : dataBuku.where((book) {
            String title = book['judulBuku'].toString().toLowerCase();
            String author = book['penulisBuku'].toString().toLowerCase();
            String queryLower = query.toLowerCase();
            return title.contains(queryLower) || author.contains(queryLower);
          }).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredData[index]['judulBuku']),
          subtitle: Text(filteredData[index]['penulisBuku']),
          onTap: () {
            // Show the search results
            showResults(context);
          },
        );
      },
    );
  }

  Widget cardBuku(data) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, PeminjamanScreens.routeName,
        //     arguments: data);
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white))),
                child: Image.asset('assets/images/buku1.jpg'),
              ),
              title: Text(
                '${data['judulBuku']}',
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penulis',
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data['penulisBuku']}',
                    style: TextStyle(
                        color: mSubtitleColor, fontWeight: FontWeight.bold),
                  ),
                  data['sedia'] == true
                      ? Text(
                          'Tersedia',
                          style: TextStyle(
                              color: kColorGreen, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Dalam Peminjaman',
                          style: TextStyle(
                              color: kColorRedSlow,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
