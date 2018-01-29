// @flow

const isEmpty = (registry: Registry) => {
	return (eventName: string) => {
		return !registry[eventName];
	};
}

type Registry = {
	[key: string]: Array<Function>
}

class NavigatorEventCallbackRegistry {
	registry: Registry;

	constructor() {
		this.registry = {};
		this.isEmpty = isEmpty(this.registry);
	}
	/**
	 * @description Register new Function for an event
	 * @param {string} eventName - event name
	 * @param {Function} callback - callback to invoke
	 */
	on(eventName: string, callback: Function) {
		if (this.isEmpty(eventName)) {
			this.registry[eventName] = [];
		}
		this.registry[eventName].push(callback);
	}

	/**
	 * @description Returns registered functions for specific event
	 * @param {String} eventName 
	 * @returns {Array} callbacks
	 */
	_getCallbacks(eventName: string): ?Array<Function> {
		return this.registry[eventName];
	}

	/**
	 * @description Remove function from event registry
	 * @param {String} eventName - event name
	 * @param {Function} callback - callback to remove
	 */
	off(eventName: string, callback: Function) {
		if (this.isEmpty(eventName)) {
			return;
		}
		const callbackIndex = this.registry[eventName].indexOf(callback);
		if (callbackIndex !== -1) {
			this.registry[eventName].splice(index, 1);
		}
	}

	/**
	 * @description Emit a new event and invoke registered functions
	 * @param {String} eventName - event name
	 * @param {Any} args - Emitted event data
	 */
	emit(eventName: string, args?: mixed) {
		const callbacks =  this._getCallbacks(eventName);
		if (!callbacks) {
			return;
		}
		callbacks.forEach(fn => {
			fn(args);
		});
	}
}

export default new NavigatorEventCallbackRegistry();