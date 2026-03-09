import 'package:flutter/material.dart';

class ScrollableViews extends StatelessWidget {
  const ScrollableViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scrollable Views"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // Title
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "ListView Example",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Horizontal ListView
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.all(8),
                    color: Colors.blue[(index + 1) * 100],
                    child: Center(
                      child: Text(
                        "Card $index",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            // GridView title
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "GridView Example",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // GridView
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemCount: 8,

              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  color: Colors.primaries[index %
                      Colors.primaries.length],

                  child: Center(
                    child: Text(
                      "Item $index",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}