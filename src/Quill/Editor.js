'use strict';

exports.newImpl = function(el, config) {
    /* bounds makes sure all tooltips
     * are within the container
     */
    config.bounds  = el;
    return new Quill(el, config);
};
