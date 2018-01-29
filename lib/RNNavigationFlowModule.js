import SafeModule from 'react-native-safe-module';

const noop = () => {};

const RNNavigationFlow = SafeModule.module({
	moduleName: 'ReactNavigationFlow',
	mock: {
		push: noop,
		present: noop,
		pop: noop,
		dismiss: noop,
		firstRenderComplete: noop,
		VERSION: -1,
		instanceIdKey: 'instanceIdKey',
		events: {
			didMountEvent: '-1'
		},
	}
});

RNNavigationFlow.generateDidMountEvent = function(instanceId) {
	return `${this.events.didMountEvent}-${instanceId}`
}
export default RNNavigationFlow;