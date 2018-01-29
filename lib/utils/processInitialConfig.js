// @flow

import { processColor } from 'react-native';

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