// @flow

import { AppRegistry, processColor } from 'react-native';
import SimplyNavigation from './RNNavigationFlowModule';
import wrapScreen from './utils/wrapScreen';
import processInitialConfig from './utils/processInitialConfig';

type RegisterOptions = {
	waitForRender?: boolean,
	initialConfig?: {}
};

type PushOptions = {
	data?: mixed,
	animated?: boolean,
	backGestureEnabled?: boolean,
};

class ReactNavigationFlow {
	registerScreen(
		screenName: string,
		fn: Function,
		options?: RegisterOptions = {},
	) {
		const wrappedScene = wrapScreen(screenName, fn);
		AppRegistry.registerComponent(
			screenName,
			() => {
				fn();
				return wrappedScene;	
			}
		);
		SimplyNavigation.registerScreen(
			screenName,
			options.initialConfig ? processInitialConfig(options.initialConfig) : null,
			!!options.waitForRender
		);
		return this
	}
	push(screenName: string, options: PushOptions = {}) {
		console.log(screenName, options);
		SimplyNavigation.push(screenName, options);
	}
	pop(animated?: boolean) {
		// TODO
	}
	present(screenName: string, option: PushOptions) {
		// TODO
	}
	dismiss(animated?: boolean) {
		// TODO
	}
}

export default new ReactNavigationFlow();