// @flow

export type RegisterOptions = {
	waitForRender?: boolean,
	initialConfig?: {}
};

export type PushOptions = {
	data?: mixed,
	animated?: boolean,
	backGestureEnabled?: boolean,
	modalPresentationStyle?: ModalPresentationStyle,
	isNavigationBarHidden?: boolean,
};

export type ModalPresentationStyle =
	| 'none'
	| 'custom'
	| 'popover'
	| 'pageSheet'
	| 'formSheet'
	| 'fullScreen'
	| 'overFullScreen'
	| 'currentContext'
	| 'overCurrentContext';

export interface Navigator = {
	registerScreen(screenName: string, fn: Function, options: RegisterOptions);
	push(screenName: string, data: any = {}, options: PushOptions = {}): Promise<*>;
	pop(data: any, options: { animated: boolean });
	present(screenName: string, data: any = {}, options: PushOptions = {}): Promise<*>;
	dismiss(data: any, options: { animated: boolean });
};