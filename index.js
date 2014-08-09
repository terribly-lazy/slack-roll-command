var PEG = require('pegjs'),
    path = require('path'),
    fs = require('fs');

var parser = PEG.buildParser(
    fs.readFileSync(
        path.resolve(__dirname, "roll.pegjs")
    ).toString()
);

function roll(text) {
    return "" + parser.parse(text);
}

module.exports = function(configuration) {
    return function(ee) {
        ee.on('roll', function(slack) {
            try {
                slack.replyUser(roll(slack.text));
            } catch (e) {
                slack.error(e.toString());
            }
        });
    };
}