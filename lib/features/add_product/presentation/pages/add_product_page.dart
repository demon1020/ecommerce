import 'package:ecommerce/core.dart';
import 'package:flutter/services.dart';

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
                            AppTextField(
                              controller: _nameController,
                              title: "Product Name",
                              hintText: "Enter product name",
                              inputFormatter: [],
                              enabled: true,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Product name cannot be empty';
                                }
                                if (value.length < 3) {
                                  return 'Product name must be at least 3 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            AppTextField(
                              controller: _descriptionController,
                              title: "Product Description",
                              hintText: "Enter product description",
                              inputFormatter: [],
                              enabled: true,
                              maxLines: 3,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Description cannot be empty';
                                }
                                if (value.length < 10) {
                                  return 'Description must be at least 10 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            AppTextField(
                              controller: _priceController,
                              title: "Product Price",
                              hintText: "Enter product price",
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              enabled: true,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a product price';
                                }

                                final parsedValue = int.tryParse(value);
                                if (parsedValue == null || parsedValue <= 0) {
                                  return 'Please enter a valid price greater than 0';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _imagePath == null
                                ? SizedBox(
                                    height: 100.h,
                                    width: ScreenUtil().screenWidth,
                                    child: OutlinedButton(
                                      onPressed: _pickImage,
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Setting border radius
                                        ),
                                      ),
                                      child:
                                          const Text('+ Upload Product Image'),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(_imagePath!),
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            const SizedBox(height: 50),
                            Center(
                              child: AppPrimaryButton(
                                label: "Add Product",
                                onClick: () {
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
                                    if (_imagePath == null) {
                                      return Utils.snackBar(
                                          "Please upload image",
                                          result: Result.error);
                                    }
                                    Utils.snackBar("Please fill all fields",
                                        result: Result.error);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
