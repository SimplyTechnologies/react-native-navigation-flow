// @flow

import { processColor } from 'react-native';

const COLOR_REGEX = /color$/i;

function isColor(key) {
	return COLOR_REGEX.test(key);
}

function processConfig(config) {
	const newConfig = {};

	const keys = Object.keys(config);
	keys.forEach(key => {
		if (isColor(key)) {
			newConfig[key] = processColor(config[key]);
			return;
		}
		newConfig[key] = config[key];
	});
	return newConfig;
}

export default processConfig;