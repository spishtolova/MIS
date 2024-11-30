import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Апликација за купување облека',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: ClothingListScreen(),
    );
  }
}

class ClothingListScreen extends StatelessWidget {
  // Листа со облека
  final List<Map<String, String>> clothingItems = [
    {
      'name': 'Маица',
      'image': 'https://cdn.pixabay.com/photo/2017/01/13/04/56/t-shirt-1976334_1280.png',
      'description':
          'Памучна маица со кратки ракави. Совршена за топли денови, изработена од 100% памук. Лесно се пере и достапна во различни големини.',
      'price': '500 ден.'
    },
    {
      'name': 'Панталони',
      'image': 'https://i.ebayimg.com/images/g/4OcAAOSwG35mCuyM/s-l400.jpg',
      'description':
          'Машки панталони со елегантен изглед и удобна текстура. Совршени за формални и пригоди. Боја: крем.',
      'price': '1200 ден.'
    },
    {
      'name': 'Зимска Јакна',
      'image': 'https://m.media-amazon.com/images/I/61FRgVZBhzL._AC_SX569_.jpg',
      'description':
          'Зимска јакна со подлога од синтетички материјал за максимална топлина. Водоотпорна, со големи џебови. Идеална за зимски авантури.',
      'price': '2500 ден.'
    },
    {
      'name': 'Snapback Капа',
      'image': 'https://halesspeedshop.com/cdn/shop/files/GraffitiHatBlack-Red_1.jpg?v=1686602412&width=1200',
      'description':
          'Модерна Snapback капа за урбан стил. Со прилагодлива величина. Идеална за заштита од сонце и надополнување на секојдневниот изглед.',
      'price': '300 ден.'
    },
    <String, String>{
      'name': 'Тренерки',
      'image': 'https://m.media-amazon.com/images/I/812LqxNiaML._AC_SY879_.jpg',
      'description': 'Меки и растегливи тренерки, идеални за спорт и рекреација. Достапни во повеќе бои.',
      'price': '800 ден.'
    },
     <String, String>{
      'name': 'Кошула',
      'image': 'https://rukminim2.flixcart.com/image/850/1000/xif0q/shirt/z/g/d/xl-st2-vebnor-original-imagpw72vhqfczsp.jpeg?q=90&crop=true',
      'description': 'Eластична кошула од памук, совршена за формални пригоди. Боја: небесно сина.',
      'price': '1200 ден.'
    },
      <String, String>{
      'name': 'Шорцеви',
      'image': 'https://m.media-amazon.com/images/I/71hn9XWIQCL._AC_UY1000_.jpg',
      'description': 'Лесни и удобни шорцеви за летни денови. Изработени од тенок материјал.',
      'price': '600 ден.'
    },
      <String, String>{
      'name': 'Шал',
      'image': 'https://www.evacassis.com.au/cdn/shop/products/EvaCassis_247_1024x.jpg?v=1676450240',
      'description': 'Шал изработен од мек материјал, кој нуди топлина и стил. Боја: сива.',
      'price': '350 ден.'
    },
      <String, String>{
      'name': 'Патики',
      'image': 'https://www.beckettsimonon.com/cdn/shop/products/color_whitegum_1_morgentrainers.jpg?v=1618315593',
      'description': 'Лесни и удобни патики за секојдневна употреба. Достапни големини: 41, 43, 44, 45',
      'price': '3000 ден.'
    },
  ];

  ClothingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('211171 - Пиштолова Слободанка'),
        backgroundColor: Colors.blue[30],
      ),
      body: ListView.builder(
        itemCount: clothingItems.length,
        itemBuilder: (context, index) {
          final item = clothingItems[index];
          return Card(
            color: Colors.blue[30],
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item['image']!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                item['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                item['price']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothingDetailScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ClothingDetailScreen extends StatelessWidget {
  final Map<String, String> item;

  const ClothingDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']!),
        backgroundColor: Colors.blue[30],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item['image']!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item['name']!,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Цена: ${item['price']}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item['description']!,
              style: const TextStyle(fontSize: 18, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

