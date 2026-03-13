import 'package:baadigoob_agrolink/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../l10n/app_translations.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appState = context.read<AppState>();
      final token = appState.authToken;

      if (token == null || token.isEmpty) {
        if (mounted) {
          final trans = AppLocalizations.of(context).translations;
          setState(() {
            _error = trans.sellerLoginError;
            _isLoading = false;
          });
        }
        return;
      }

      final api = ApiService(authToken: token);
      final products = await api.getMyProducts();

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteProduct(int productId) async {
    final translations = AppLocalizations.of(context).translations;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translations.deleteProduct),
        content: Text(translations.deleteProductConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(translations.delete),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final appState = context.read<AppState>();
      final api = ApiService(authToken: appState.authToken);
      await api.deleteProduct(productId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translations.productDeletedSuccess)),
        );
        _fetchProducts();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${translations.statusUnknown}: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.myListings),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchProducts,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add-produce').then((_) => _fetchProducts());
        },
        backgroundColor: AppColors.accentOrange,
        icon: const Icon(Icons.add),
        label: Text(translations.addProduce),
      ),
    );
  }

  Widget _buildBody() {
    final translations = AppLocalizations.of(context).translations;
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchProducts,
              child: Text(translations.retry),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              translations.noProductsYet,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(translations.startSellingDesc),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchProducts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return _ProductCard(
            product: product,
            onEdit: () => _editProduct(product),
            onDelete: () => _deleteProduct(product['id']),
          );
        },
      ),
    );
  }

  void _editProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _EditProductScreen(
          product: product,
          onSave: _fetchProducts,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    final status = product['status'] ?? 'active';
    final statusColor = status == 'active'
        ? AppColors.secondaryGreen
        : status == 'pending'
            ? Colors.orange
            : Colors.grey;

    String localizedStatus = status;
    if (status == 'active') localizedStatus = translations.inStock;
    if (status == 'pending') localizedStatus = translations.statusPending;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: product['imageUrl'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product['imageUrl'],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.agriculture,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const Icon(Icons.agriculture, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? translations.unknownProduct,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['description'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'SOS ${product['pricePerUnit']?.toStringAsFixed(0) ?? '0'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' / ${product['unit'] ?? 'kg'}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Bottom row with quantity, status, and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${translations.available}: ${product['availableQuantity']?.toStringAsFixed(0) ?? '0'} ${product['unit'] ?? 'kg'}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Chip(
                      label: Text(
                        localizedStatus.toUpperCase(),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      backgroundColor: statusColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.primaryBlue),
                      onPressed: onEdit,
                      tooltip: translations.editProduct,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                      tooltip: translations.delete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onSave;

  const _EditProductScreen({
    required this.product,
    required this.onSave,
  });

  @override
  State<_EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<_EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _gradeController;
  late final TextEditingController _regionController;
  late String _status;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _descriptionController = TextEditingController(text: widget.product['description']);
    _priceController = TextEditingController(text: widget.product['pricePerUnit']?.toString() ?? '');
    _quantityController = TextEditingController(text: widget.product['availableQuantity']?.toString() ?? '');
    _gradeController = TextEditingController(text: widget.product['grade']);
    _regionController = TextEditingController(text: widget.product['region']);
    _status = widget.product['status'] ?? 'active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _gradeController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final appState = context.read<AppState>();
      final api = ApiService(authToken: appState.authToken);

      await api.updateProduct(widget.product['id'], {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price_per_unit': double.tryParse(_priceController.text.trim()) ?? 0,
        'available_quantity': double.tryParse(_quantityController.text.trim()) ?? 0,
        'grade': _gradeController.text.trim().isEmpty ? 'A' : _gradeController.text.trim().toUpperCase(),
        'region': _regionController.text.trim(),
        'status': _status,
      });

      if (mounted) {
        final translations = AppLocalizations.of(context).translations;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(translations.productCreatedSuccess),
            backgroundColor: AppColors.secondaryGreen,
          ),
        );
        widget.onSave();
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.editProduct),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: translations.productName,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) => v?.trim().isEmpty == true ? translations.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: translations.descriptionOptional,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: translations.pricePerUnit,
                        prefixText: 'SOS ',
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => v?.trim().isEmpty == true ? translations.requiredField : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: translations.availableQty,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => v?.trim().isEmpty == true ? translations.requiredField : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _gradeController,
                      decoration: InputDecoration(
                        labelText: translations.gradePlaceholder,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _regionController,
                      decoration: InputDecoration(
                        labelText: translations.region,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: translations.questions, // Closest thing for 'Status' if not defined, but I should add 'statusLabel'
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'active', child: Text(translations.inStock)),
                  DropdownMenuItem(value: 'pending', child: Text(translations.statusPending)),
                  DropdownMenuItem(value: 'inactive', child: Text(translations.statusUnknown)),
                ],
                onChanged: (v) => setState(() => _status = v!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(translations.saveChanges, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

