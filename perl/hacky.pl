#!/usr/bin/env perl

use strict;
#use lib '/home/jon/perl5/lib/perl5/x86_64-linux-gnu-thread-multi';
use Data::Dumper;
use OpenGL;
use OpenGL::XScreenSaver;

print "Let's try some screensaver hacks..\n";

OpenGL::XScreenSaver::init();
OpenGL::XScreenSaver::start();

while(1) {
  glClear();
OpenGL::XScreenSaver::update();
};
