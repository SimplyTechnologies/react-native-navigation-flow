// @flow

import { AppRegistry, processColor } from 'react-native';
import SimplyNavigation from './RNNavigationFlowModule';
import wrapScreen from './utils/wrapScreen';
import processInitialConfig from './utils/processInitialConfig';
import type { RegisterOptions, PushOptions } from './typeDefinitions';
class ReactNavigationFlow {
	registerScreen(
		screenName: string,
		fn: Function,
		options?: RegisterOptions = {},
	) {
		const wrappedScene = wrapScreen(screenName, fn, this);
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
	push(screenName: string, data: any = {}, options: PushOptions = {}): Promise<*> {
		return SimplyNavigation.push(
			screenName,
			data,
			options
		);
	}
	pop(data: any, options: { animated: boolean }) {
		SimplyNavigation.pop(
			data,
			options
		);
	}
	present(screenName: string, data: any = {}, options: PushOptions = {}): Promise<*> {
		return SimplyNavigation.present(
			screenName,
			data,
			options
		);
	}
	dismiss(data: any, options: { animated: boolean }){
		return SimplyNavigation.dismiss(
			data,
			options
		);
	}
}

export default new ReactNavigationFlow();