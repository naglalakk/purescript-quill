'use strict';

exports.newImpl = function(el, config) {
    var modules = {
        syntax: true,
        toolbar: [config.formats]
    }
    config.modules = modules;
    /* bounds makes sure all tooltips
     * are within the container
     */
    config.bounds  = el;
    return new Quill(el, config);
};
