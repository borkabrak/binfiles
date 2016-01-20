
// Ellipsify - a jQuery extension to truncate the text content of an element.

jQuery.fn.extend({

    /** 
    * ellipsify()
    *      Truncate the text content of an element to a given length,
    *      appending an indication that this has been done. (an ellipsis by
    *      default).
    *
    *      Options can be given either as named properties on a parameter to
    *      this function, or as data attributes on the HTML element.
    *
    *
    *      OPTIONS: 
    *
    *          'maxlength': <number> (REQUIRED)
    *              Maximum allowed length of the text before truncation occurs.
    *
    *          'ellipsis':
    *              String with which to replace the remainder of the text.
    *              Defaults to an actual ellipsis ('…'), but can be anything.
    *
    *          'href':
    *              Render the appended text as a link, with this as the
    *              destination.
    *
    */
    ellipsify: function(options) {
        "use strict";

        options && options.debug && console.log("Debug:%o", options.debug);
        var maxlength = options && options.maxlength || this.data("maxlength");
        if (typeof maxlength !== "number") {
            console && console.error("ellipsify(): A 'maxlength' number must be specified, either as an option or as a data attribute.");
            return;
        }

        // We do *anything* only if the element's text is too long.
        var text = /\s*(.*)\s*/.exec(this.text())[1];

        if (text.length > maxlength) {

            // truncate the text
            this.text(text.slice(0,maxlength));

            // build the trailing element
            var appendedElement = document.createElement("i");
            $(appendedElement).text( (options && options.ellipsis) || this.data("ellipsis") ? (options && options.ellipsis || this.data("ellipsis")) : "…");

            // If we have an href, build and use an appropriate anchor
            if ((options && options.href) || this.data("href")) {
                var anchor = document.createElement("a");
                anchor.setAttribute("href", (options && options.href) || this.data("href"));
                anchor.innerHTML = $(appendedElement).text();
                this.append(anchor);
            } else {
                this.append(appendedElement);
            }

        }

        return this;
    }

});
