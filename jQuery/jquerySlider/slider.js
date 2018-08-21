// JScript source code
(function ($) {
    var sliderUL = $('div.slider').css('overflow', 'hidden').children('ul'),
        imgs = sliderUL.find('img'),
        imgWidth = imgs[0].width, // 600
        imgsLen = imgs.length, // 4
        current = 1,
        totalImgsWidth = imgsLen * imgWidth; //2400

    $('#slider-nav').show().find('button').on('click', function () {
        clearInterval(intervalId); //stop automateSlider
        //console.log('button clicked');
        var direction = $(this).data('dir'),
                loc = imgWidth; //600

        //console.log(direction);

        //update current value
        (direction === 'next') ? ++current : --current;

        //if first image
        if (current === 0) {
            current = imgsLen;
            loc = totalImgsWidth - imgWidth; //1800
            direction = 'next';
        } else if (current - 1 === imgsLen) {// Are we at end? Should we reset?
            current = 1;
            loc = 0;
        }
        transition(sliderUL, loc, direction);
    });

    function transition(container, loc, direction) {
        var unit; //-= +=
        if (direction && loc !== 0) {
            console.log("DIRECTION: " + direction + "LOCATION: " + loc);
            unit = (direction === 'next') ? '-=' : '+=';
        }
        container.animate({
            'margin-left': unit ? (unit + loc) : loc
        });
    }

    var intervalId = setInterval(function () { automateSlider(); }, 4000);

    function automateSlider() {
        ++current;
        loc = imgWidth;
        unit = "-="
        if (current - 1 === imgsLen) {
            current = 1;
            loc = 1800;
            unit = "+=";
        }

        sliderUL.animate({
            'margin-left': (unit + loc)
        });
        //console.log("cur:" + current + "loc:" + loc + "unit:" + unit);
    }
})(jQuery);