function footerPlugin(hook) {
	var footer = [
		'<hr />',
		'<footer>',
		'<span>Is something wrong with the documentation ? <a href="https://github.com/simplyTechnologies/react-native-navigation-flow/tree/master/docs" target="_blank">Edit documentation on Github!</a>.</span>'
	].join('');

	hook.afterEach(function (html) {
		return html + footer;
	});
}