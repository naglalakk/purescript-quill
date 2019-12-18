'use strict';

exports.newImpl = function(el, config) {
    var modules = {
        syntax: true,
        toolbar: [config.formats]
    }
    config.modules = modules;
    return new Quill(el, config);
};
