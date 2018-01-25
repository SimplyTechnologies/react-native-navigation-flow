// @flow

import SimplyNavigation from './RNNavigationFlowModule';

type RegisterOptions = {
	
};

type PushOptions = {
	passData?: mixed,
	animated?: boolean,
	backGestureEnabled?: boolean,
};

class ReactNavigationFlow {
	registerScreen(screenName: string, options: RegisterOptions) {
		// TODO
	}
	push(screenName: string, option: PushOptions) {
		// TODO
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