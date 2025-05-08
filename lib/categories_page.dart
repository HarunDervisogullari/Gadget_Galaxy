
import 'package:flutter/material.dart';
import 'product.dart';
import 'category_products_page.dart';

class Category {
  final String name;
  final String imageAsset;
  final List<Product> products;

  Category(this.name, this.imageAsset, this.products);
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(category: category),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/category_images/${category.imageAsset}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsPage(category: category),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CategoryGrid extends StatelessWidget {
  final List<Category> categories = [
    Category('Audio and Headphones', 'audio.png', [
      Product('Sennheiser Professional ', 88.99, ['Brand: Sennheiser Pro Audio ', 'Model Name:	HD 280 Pro ','Color: Black ', 'Form Factor:	Over Ear', 'Connectivity Technology: Wired '], 'assets/category_images/61+XjHbWrZL._AC_SL1312_.png', 'Audio and Headphones',1),
      Product('Sony MDR7506', 78.19, ['Brand:Sony ', 'Model Name:Sony MDR ','Color:Black ', 'Form Factor:	Over Ear', 'Connectivity Technology: Wired'], 'assets/category_images/61USpC8rfrL._AC_SL1500_.png', 'Audio and Headphones',2),
      Product('Kikc Gaming Headset', 19.99, ['Brand:	Kikc ', 'Model Name:PS-4 ','Color:Blue ', 'Form Factor :Over Ear', 'Connectivity Technology:Wired '], 'assets/category_images/Gaming Headset.png', 'Audio and Headphones',3),


    ]),
    Category('Laptops and Computers', 'laptop.png', [
      Product('HP 14 Laptop', 181.00, ['Brand:HP ', 'Model Name:14-dq0040nr ','Screen Size:14 Inches ', 'Color:Snowflake White', 'Hard Disk Size:64 GB '], 'assets/category_images/1.png', 'Laptops and Computers',6),
      Product('Acer Aspire', 299.99, ['Brand:acer', 'Model Name:Laptop','Screen Size:	15.6 Inches ', 'Color:	Silver', 'Hard Disk Size: 128 GB '], 'assets/category_images/2.png', 'Laptops and Computers',7),
      Product('Dell Newest 13th', 905.99, ['Brand:Dell ', 'Model Name: nspiron 15 3530 ','Screen Size: 15.6 Inches ', 'Color:Black', 'Hard Disk Size: 1 TB'], 'assets/category_images/3.png', 'Laptops and Computers',8),
      Product('Lenovo IdeaPad 1', 165.96, ['Brand: 	Lenovo', 'Model Name:	IdeaPad 3i ','Screen Size: 14 Inches ', 'Color:Gray', 'Hard Disk Size:128 GB '], 'assets/category_images/4.png', 'Laptops and Computers',9),
    ]),
    Category('Cameras and Photography', 'camera.png', [
      Product('Canon EOS', 479.00, ['Brand:Canon', 'Model Name:EOS REBEL T7 18-55mm f/3.5-5.6 IS II Kit ','Photo Sensor Size	APS-H ', 'Color:	Silver', 'Max Shutter Speed	30 seconds '], 'assets/category_images/5.png', 'Cameras and Photography',10),
      Product('Kodak AZ401RD ', 116.98, ['Brand:	Kodak ', 'Model Name: AZ401RD','Maximum Webcam Image Resolution	16 MP ', 'Photo Sensor Size	1/2.3-inch', 'Image Stabilization	Optical '], 'assets/category_images/6.png', 'Cameras and Photography',11),
      Product('Mo Digital Camera', 149.99, ['Brand:Monitech ', 'Connectivity Technology	USB, HDMI','Color: Black', 'Screen Size: 3 Inches', 'Video Capture Resolution: 4K'], 'assets/category_images/7.png', 'Cameras and Photography',12),

    ]),
    Category('Drones and Accessories', 'drone.png', [
      Product('STARTRC Drone', 69.99, ['Brand: 	STARTRC', 'Special Feature: Long Distance Control ','Color: Black', 'Connectivity Technology: No', 'Item Weight: 290 Grams '], 'assets/category_images/8.png', 'Drones and Accessories',18),
      Product('RADCLO Mini ', 53.99, ['Brand:RADCLO ', 'Model Name:GM-100A ','Color:	Black  ', 'Video Capture: Resolution	1080p', 'Control Type	app'], 'assets/category_images/9.png ', 'Drones and Accessories',14),
      Product('le-idea 12Pro', 89.99, ['Brand:le-idea ', 'Model Name:IDEA12 PRO ','Age Range (Description)	Adult ', 'Video Capture Resolution	4K', 'Connectivity Technology	Wi-Fi '], 'assets/category_images/10.png', 'Drones and Accessories ',15),


    ]),
    Category('Monitors and Displays', 'monitor.png', [
      Product('KOORUI 22', 69.98, ['Screen Size: 22 Inches', 'Display Resolution Maximum	1920 x 1080 Pixels','Brand	KOORUI ', 'Special Feature	Blue Light Filter, Frameless, Tilt Adjustment, Flicker-Free, Eye Care', 'Refresh Rate	75 Hz '], 'assets/category_images/11.png', 'Monitors and Displays',23),
      Product('VILVA Portable-Monitor', 75.95, ['Screen Size	15.6 Inches ', 'Display Resolution Maximum	1920 x 1080 Pixels','Brand	VILVA ', 'Special Feature	Portable', 'Refresh Rate	60 Hz '], 'assets/category_images/12', 'Monitors and Displays',21),
      Product('SANSUI', 88.99, ['Screen Size	24 Inches ', 'Display Resolution Maximum	1920 x 1080 Pixels','Brand	SANSUI', 'Special Feature	Built-In Speakers', 'Refresh Rate	100 Hz'], 'assets/category_images/13', 'Monitors and Displays',22),

    ]),


    Category('Smartphones and Accessories', 'phonoacc.png', [
      Product('BLU G50 Mega', 64.99, ['Brand: 	BLU', 'Model Name:	G50 ','Wireless Carrier	Unlocked', 'Operating System	Android', 'Cellular Technology	4G '], 'assets/category_images/14', 'Smartphones and Accessories',31),
      Product('IIIF150 Air1 Ultra', 239.99, ['Brand:IIIF150 ', 'Model Name:	Ultra White','Wireless Carrier:	Helio ', 'Operating System:	android', 'Cellular Technology:	4G '], 'assets/category_images/15', 'Smartphones and Accessories',30),
      Product('SANSHREUNI A15', 159.99, ['Brand:SANSHREUNI ', 'Model Name:A15 Pro Max ','Wireless Carrier:	Unlocked for All Carriers', 'Operating System:	Android 13.0', 'Cellular Technology:	5G/4G '], 'assets/category_images/16', 'Smartphones and Accessories',35),

    ]),


  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryItem(category: categories[index]);
      },
    );
  }


  List<Product> getAllProducts() {
    List<Product> allProducts = [];
    categories.forEach((category) {
      allProducts.addAll(category.products);
    });
    return allProducts;
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/products'),
            fit: BoxFit.cover,
          ),
        ),
        child: CategoryGrid(),
      ),
    );
  }
}

