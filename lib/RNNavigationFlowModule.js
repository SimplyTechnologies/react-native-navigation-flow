import SafeModule from 'react-native-safe-module';

const noop = () => {};

const RNNavigationFlow = SafeModule.module({
	moduleName: 'ReactNavigationFlow',
	mock: {
		push: noop,
		present: noop,
		pop: noop,
		dismiss: noop,
	}
});

export default RNNavigationFlow;