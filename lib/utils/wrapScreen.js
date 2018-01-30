// @flow

import React, { Component } from 'react';
import { DeviceEventEmitter } from 'react-native';
import navigationEmitter from '../navigatorEventCallbackRegistry';
import RNNavigationFlowModule from '../RNNavigationFlowModule';
import PropTypes from 'prop-types';

type Props = {
	navigator: {
		data: {},
	},
	navFlowInstanceId: string
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
		constructor(props: Props, context: mixed) {
			super(props, context);
			DeviceEventEmitter.addListener(
				`NavigationFlowScreen-willAppear-${props.navFlowInstanceId}`,
				this.componentWillAppear
			);
			DeviceEventEmitter.addListener(
				`NavigationFlowScreen-didAppear-${props.navFlowInstanceId}`,
				this.componentDidAppear
			)
			DeviceEventEmitter.addListener(
				`NavigationFlowScreen-willDisappear-${props.navFlowInstanceId}`,
				this.componentWillDisappear
			)
			DeviceEventEmitter.addListener(
				`NavigationFlowScreen-didDisappear-${props.navFlowInstanceId}`,
				this.componentDidDisappear
			);

			this.RootComponent = unwrapScreen(fn);
		}
		static childContextTypes = {
			navFlowInstanceId: PropTypes.string.isRequired
		}
		getChildContext() {
			return {
				navFlowInstanceId: this.props.navFlowInstanceId
			};
		}

		componentWillAppear = () => {
			if (typeof this.RootComponent.prototype.componentWillAppear === 'function') {
				this.RootComponent.prototype.componentWillAppear();
			}
		}

		componentDidAppear = () => {
			if (typeof this.RootComponent.prototype.componentDidAppear === 'function') {
				this.RootComponent.prototype.componentDidAppear();
			}
		}

		componentWillDisappear = () => {
			if (typeof this.RootComponent.prototype.componentWillDisappear === 'function') {
				this.RootComponent.prototype.componentWillDisappear();
			}
		}

		componentWillUnmount() {
			this.RootComponent = null;
		}

		componentDidDisappear = () => {
			if (typeof this.RootComponent.prototype.componentDidDisappear === 'function') {
				this.RootComponent.prototype.componentDidDisappear();
			}
		}


		componentDidMount() {
			navigationEmitter.emit(
				RNNavigationFlowModule.generateDidMountEvent(this.props.navFlowInstanceId),
			);
			RNNavigationFlowModule.firstRenderComplete(this.props.navFlowInstanceId);
		}
		render() {
			const { RootComponent } = this;
			return <RootComponent {...this.props} />
		}
	}
	WrappedScreen.displayName = `WrappedScene(${screenName})`;

	return WrappedScreen;
}

export default wrapScreen;