(def left-pad (js/require "left-pad"))

(js/console.log (left-pad 256 10 0))

(js/console.log (.toString (js/fs.readFileSync "/tmp/t")))