import 'package:flutter/material.dart';
import 'package:untitled4/invoice.dart';
import 'package:untitled4/invoice_page.dart';
import 'product.dart';

void main() {
  runApp(
      MaterialApp(
        
        home: MainPage(),
      )
  );
}
TextEditingController cnameController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

class MainPage extends StatefulWidget {
  List<Product> products=[];
  List<Invoice> invoices = [];
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int invoiceNo = 1;
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text('Product Info',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: false,
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'product name',
              ),
            ),
            TextField(
              autofocus: false,
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'price',
              ),
            ),
            TextField(
              autofocus: false,
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'quantity',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                widget.products.add(
                    Product(
                        name: nameController.text,
                        price: double.parse(priceController.text),
                        quantity: int.parse(quantityController.text)
                    )
                );
                Navigator.of(context).pop();
                setState(() {
                  nameController.clear();
                  priceController.clear();
                  quantityController.clear();
                });
              },
              child: const Text('add'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('cancel'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# $invoiceNo'),
      ),
      body: Column(

        children: [
          TextField(
            autofocus: false,
            controller: cnameController,
            decoration: const InputDecoration(
              labelText: 'customer name',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Products:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: const Text('add product'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue,
                      leading: Text(widget.products[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      title: Text('price: ${widget.products[index].price}'),
                      subtitle: Text('quantity: ${widget.products[index].quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {

                        },
                      ),
                    ),
                  );
                },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                  onPressed: () {
                    widget.invoices.add(
                      Invoice(invoiceNo: invoiceNo++, cName: cnameController.text, products: widget.products)
                    );
                    cnameController.clear();
                    widget.products = [];
                    setState(() {

                    });
                  },
                  child: Text('add invoice')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicesPage(widget.invoices),));
                  },
                  child: Text('show all invoices')
              ),
            ],
          ),
        ],
      ),
    );
  }
}