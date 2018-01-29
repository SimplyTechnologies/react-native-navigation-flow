// @flow

import React, { Component } from 'react';
import navigationEmitter from '../navigatorEventCallbackRegistry';
import RNNavigationFlowModule from '../RNNavigationFlowModule';

type Props = {
	navFlowInstanceId: string,
};

function unwrapScreen(fn: Function): Component<*> {
	const screen = fn();
	if (screen.__esModule) {
		return screen.default
	}
	return screen;
}

function wrapScreen(screenName: string, fn: Function): Component<Props, *> {
	class WrappedScreen extends Component<Props, void> {
		getChildContext() {
			return {
				navFlowInstanceId: this.props.navFlowInstanceId
			};
		}

		componentDidMount() {
			navigationEmitter.emit(
				RNNavigationFlowModule.generateDidMountEvent(this.props.navFlowInstanceId),
			);
			RNNavigationFlowModule.firstRenderComplete(this.props.navFlowInstanceId);
		}
		render() {
			const SceneRoot = unwrapScreen(fn);
			return <SceneRoot {...this.props} />
		}
	}
	WrappedScreen.displayName = `WrappedScene(${screenName})`;

	return WrappedScreen;
}

export default wrapScreen;