import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';

class AddProduceScreen extends StatefulWidget {
  const AddProduceScreen({super.key});

  @override
  State<AddProduceScreen> createState() => _AddProduceScreenState();
}

class _AddProduceScreenState extends State<AddProduceScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _regionController = TextEditingController();
  final _gradeController = TextEditingController();
  final _unitController = TextEditingController(text: 'kg');

  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _minOrderController.dispose();
    _regionController.dispose();
    _gradeController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final appState = context.read<AppState>();
    final token = appState.authToken;

    if (token == null || token.isEmpty) {
      final trans = AppLocalizations.of(context).translations;
      setState(() {
        _error = trans.sellerLoginError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final api = ApiService(authToken: token);

    try {
      await api.createProduct({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price_per_unit': double.tryParse(_priceController.text.trim()) ?? 0,
        'available_quantity':
            double.tryParse(_quantityController.text.trim()) ?? 0,
        'min_order_quantity':
            double.tryParse(_minOrderController.text.trim()) ?? 1,
        'unit': _unitController.text.trim(),
        'grade': _gradeController.text.trim().isEmpty
            ? 'A'
            : _gradeController.text.trim().toUpperCase(),
        'region': _regionController.text.trim().isEmpty
            ? null
            : _regionController.text.trim(),
        'status': 'active',
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).translations.productCreatedSuccess),
          backgroundColor: AppColors.secondaryGreen,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
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
        title: Text(translations.addProduce),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                translations.addProduceDesc,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textMedium),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: translations.productName,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return translations.enterName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
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
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: translations.pricePerUnit,
                        border: const OutlineInputBorder(),
                        prefixText: 'SOS ',
                      ),
                       validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return translations.enterPrice;
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return translations.enterValidNumber;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _unitController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: translations.unit,
                        border: const OutlineInputBorder(),
                        hintText: 'kg',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: translations.availableQty,
                        border: const OutlineInputBorder(),
                      ),
                       validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return translations.enterQuantity;
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return translations.enterValidNumber;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _minOrderController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: translations.minOrder,
                        border: const OutlineInputBorder(),
                      ),
                       validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return translations.enterMinOrder;
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return translations.enterValidNumber;
                        }
                        return null;
                      },
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
                      textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: translations.gradePlaceholder,
                  border: const OutlineInputBorder(),
                  hintText: 'A',
                ),
      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _regionController,
                      textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: translations.region,
                  border: const OutlineInputBorder(),
                  hintText: translations.regionHint,
                ),
      ),
                    ),
                  ),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        translations.createListing,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
