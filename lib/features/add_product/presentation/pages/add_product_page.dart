import 'package:ecommerce/core.dart';
import 'package:ecommerce/core/data/repositories/hive_service.dart';

import '../../../home/data/models/product_model.dart';
import '../manager/add_product_bloc.dart';
import '../manager/add_product_event.dart';
import '../manager/add_product_state.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String? _imagePath;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully!')),
            );
          } else if (state is AddProductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AddProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Product Name'),
                              validator: (value) => value!.isEmpty
                                  ? 'Enter a product name'
                                  : null,
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a description' : null,
                            ),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Price'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a price' : null,
                            ),
                            const SizedBox(height: 20),
                            _imagePath == null
                                ? ElevatedButton(
                                    onPressed: _pickImage,
                                    child: const Text('Upload Product Image'),
                                  )
                                : Image.file(
                                    File(_imagePath!),
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      _imagePath != null) {
                                    context.read<AddProductBloc>().add(
                                          AddProductFormSubmitted(
                                            name: _nameController.text,
                                            description:
                                                _descriptionController.text,
                                            price: int.parse(
                                                _priceController.text),
                                            imagePath: _imagePath!,
                                          ),
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please fill all fields')),
                                    );
                                  }
                                },
                                child: const Text('Add Product'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: FutureBuilder<List<Product>>(
                      future: HiveService.getAll<Product>(
                          HiveService.productsBoxName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          List<Product> products = snapshot.data!;
                          return ListView.builder(
                            itemCount: products.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(products[index].title!),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('Create products!'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
