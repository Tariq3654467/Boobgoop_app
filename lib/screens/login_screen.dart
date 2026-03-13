import 'package:baadigoob_agrolink/l10n/app_localizations.dart';
import '../models/app_state.dart';
import '../theme/app_colors.dart';
import 'role_selection_screen.dart';
import 'landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final appState = context.read<AppState>();
    final result = await appState.authService.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      // Update app state with auth data
      appState.updateAuthState(
        isLoggedIn: true,
        user: result.user,
        token: result.token,
      );

      // Get user role from response and set it
      final userRole = result.user?['role']?.toString().toLowerCase();
      if (userRole != null) {
        if (userRole == 'seller' || userRole == 'farmer') {
          appState.setRole(UserRole.seller);
        } else if (userRole == 'buyer') {
          appState.setRole(UserRole.buyer);
        } else if (userRole == 'admin') {
          appState.setRole(UserRole.admin);
        } else if (userRole == 'driver') {
          appState.setRole(UserRole.driver);
        } else if (userRole == 'ops_agent' || userRole == 'ops' || userRole == 'agent') {
          appState.setRole(UserRole.opsAgent);
        } else if (userRole == 'finance') {
          appState.setRole(UserRole.finance);
        } else if (userRole == 'hub') {
          appState.setRole(UserRole.hub);
        } else if (userRole == 'partner') {
          appState.setRole(UserRole.partner);
        } else if (userRole == 'expert') {
          appState.setRole(UserRole.expert);
        }
      }

      if (mounted) {
        final translations = AppLocalizations.of(context).translations;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${translations.welcomeBackUser}, ${result.user?['first_name'] ?? translations.user}!'),
            backgroundColor: AppColors.secondaryGreen,
          ),
        );
        
        // Navigate to landing/home screen after successful login
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LandingScreen()),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.loginTitle),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo
                Icon(
                  Icons.account_circle,
                  size: 80,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(height: 24),
                
                Text(
                  translations.welcomeBack,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  translations.signInToContinue,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: translations.emailLabel,
                    hintText: translations.emailHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return translations.emailError;
                    }
                    if (!value.contains('@')) {
                      return translations.emailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                  decoration: InputDecoration(
                    labelText: translations.passwordLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return translations.passwordError;
                    }
                    if (value.length < 6) {
                      return translations.passwordTooShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(translations.forgotPasswordSoon),
                        ),
                      );
                    },
                    child: Text(translations.forgotPassword),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
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
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          translations.loginTitle,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: 24),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(translations.dontHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoleSelectionScreen(),
                          ),
                        );
                      },
                      child: Text(translations.registerLink),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

