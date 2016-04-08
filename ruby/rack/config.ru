# config.ru
#
# run 'rackup <thisfile>' to see it in action

body = <<-END
For the glass of the years is brittle wherein we gaze for a span;
A little soul for a little bears up this corpse which is man.
So long I endure, no longer; and laugh not again, neither weep.
For there is no God found stronger than death; and death is a sleep.
END
run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, body.split("\n")] }
