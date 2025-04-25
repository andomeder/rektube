//const String pipedInstanceUrl = 'http://localhost:3142';
//const String pipedInstanceUrl = 'https://7916-41-89-16-2.ngrok-free.app';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String pipedInstanceUrl = dotenv.env['PIPED_INSTANCE_URL']!;

// Secure storage keys
const String secureStorageAuthTokenKey = 'authToken';
const String secureStorageUserIdKey = 'userId';

// GetStorage keys
const String storageUsernameKey = 'lastUsername';
