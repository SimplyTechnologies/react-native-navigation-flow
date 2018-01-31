# Usage

This Page is little bit long, so take a coffee and keep reading :book:

> Note: React Native by default populates all your JS Code in one Root View. We changed that structure to keep your app's performance on the level and to provide trully native navigation. Now your app will have multiple roots and each screen will run in his own root.


So Let's start

1. How to register your screen root ?

```javascript
import { Navigation } from 'react-native-navigation-flow';
import { Screen1, Screen2 } from './screens';

Navigation
	.registerScreen('screen1', () => Screen1)
	.registerScreen('screen2', () => Screen2);
```

That's it :smile: