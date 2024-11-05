import 'package:flutter/material.dart';
import 'productDetails.dart'; // Importe a página de detalhes do produto

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final String description;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navega para a página de detalhes do produto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              imageUrl: imageUrl,
              productName: productName,
              price: price,
              description: description, // Adicione uma descrição se necessário
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                productName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'R\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
